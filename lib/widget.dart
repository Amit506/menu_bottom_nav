import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'items.dart';
import 'utils/arc_painter.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
    this.color,
    this.elevation = 4.0,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
    this.storkeWidth,
    required this.floatingbuttonsize,
    this.height = 60.0,
    required this.expandableBottomBarDetails,
    required this.shouldOpen,
    required this.onTapMenuButton,
    this.floatingButtonColor,
    this.strokeColor,
    this.activefloatingIcon,
    this.cancelMenuFloatingIcon,
    this.forwardDuration = const Duration(milliseconds: 500),
    this.reverseDuration = const Duration(milliseconds: 400),
  })  : assert(elevation == null || elevation >= 0.0),
        assert(notchMargin != null),
        assert(height != null),
        assert(clipBehavior != null),
        super(key: key);
  final VoidCallback onTapMenuButton;
  final double height;
  final Color? color;
  final double? elevation;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final bool shouldOpen;
  final BottomBarDetails expandableBottomBarDetails;
  final double notchMargin;
  final double floatingbuttonsize;
  final double? storkeWidth;
  final Color? strokeColor;
  final Color? floatingButtonColor;

  /// active floating  widget
  final Widget? activefloatingIcon;
  final Duration forwardDuration;
  final Duration reverseDuration;

  final Widget? cancelMenuFloatingIcon;

  @override
  State createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  final GlobalKey materialKey = GlobalKey();
  static const double _defaultElevation = 8.0;
  @override
  void initState() {
    if (widget.expandableBottomBarDetails.items.length == 2) {
      widget.expandableBottomBarDetails.items.insert(1, null);
    } else {
      widget.expandableBottomBarDetails.items.insert(2, null);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometryListenable.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) return bottomNavigationBarTop;
    final RenderBox? box =
        materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  double? buttonsize() {
    return geometryListenable.value.floatingActionButtonArea
        ?.translate(0.0, bottomNavigationBarTop * -1)
        .height;
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final BottomAppBarTheme babTheme = BottomAppBarTheme.of(context);
    final NotchedShape? notchedShape = widget.shape ?? babTheme.shape;
    final CustomClipper<Path> clipper = notchedShape != null
        ? _BottomAppBarClipper(
            geometry: geometryListenable,
            shape: notchedShape,
            materialKey: materialKey,
            notchMargin: widget.notchMargin,
          )
        : const ShapeBorderClipper(shape: RoundedRectangleBorder());
    final double elevation =
        widget.elevation ?? babTheme.elevation ?? _defaultElevation;
    final Color color =
        widget.color ?? babTheme.color ?? Theme.of(context).bottomAppBarColor;
    final Color effectiveColor =
        ElevationOverlay.applyOverlay(context, color, elevation);
    final IconThemeData iconTheme =
        widget.expandableBottomBarDetails.iconTheme ??
            const IconThemeData(color: Colors.black45);
    final IconThemeData activeIconTheme =
        widget.expandableBottomBarDetails.activeIconTheme ??
            const IconThemeData(color: Colors.black);
    final TextStyle textStyle = widget.expandableBottomBarDetails.titleStyle ??
        const TextStyle(
            color: Colors.black45, fontWeight: FontWeight.normal, fontSize: 12);
    final TextStyle activeTextStyle =
        widget.expandableBottomBarDetails.activeTitleStyle ??
            const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);

    return SizedBox(
      height: widget.height * 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: widget.height * 2,
            width: widget.height * 2,
            child: TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: widget.shouldOpen ? 0 : 1,
                  end: widget.shouldOpen ? 1 : 0),
              duration: widget.shouldOpen
                  ? widget.forwardDuration
                  : widget.reverseDuration,
              curve: Curves.easeInOutQuad,
              builder: (BuildContext context, double value, Widget? child) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: value,
                  child: CustomPaint(
                    painter: ArcPainter(
                        color: widget.strokeColor ?? Colors.blueAccent,
                        progress: value,
                        strokewidth: widget.storkeWidth ?? 40),
                    child: child,
                  ),
                );
              },
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                    begin: widget.shouldOpen ? -math.pi : 0,
                    end: widget.shouldOpen ? 0 : -math.pi),
                duration: widget.shouldOpen
                    ? widget.forwardDuration
                    : widget.reverseDuration,
                curve: Curves.easeInOutQuad,
                builder: (BuildContext context, double value, Widget? child) {
                  return Transform.rotate(
                    angle: value,
                    child: child,
                  );
                },
                child: ActionCircle(
                  circleItems: widget.expandableBottomBarDetails.circleItems,
                  radius: widget.height * 2,
                  color: widget.expandableBottomBarDetails.circleColors![0],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: widget.height -
                  widget.floatingbuttonsize / 1.5 +
                  widget.notchMargin,
              child: SizedBox(
                height: widget.floatingbuttonsize,
                width: widget.floatingbuttonsize,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: widget.shouldOpen ? -math.pi : 0,
                      end: widget.shouldOpen ? 0 : -math.pi),
                  duration: widget.shouldOpen
                      ? widget.forwardDuration
                      : widget.reverseDuration,
                  curve: Curves.easeInOutQuad,
                  builder: (BuildContext context, double value, Widget? child) {
                    return Transform.rotate(
                      angle: value,
                      child: child,
                    );
                  },
                  child: FloatingActionButton(
                      elevation: widget.elevation,
                      backgroundColor: widget.floatingButtonColor ?? color,
                      onPressed: widget.onTapMenuButton,
                      child: !widget.shouldOpen
                          ? widget.activefloatingIcon
                          : widget.cancelMenuFloatingIcon),
                ),
              )

              // )
              ),
          SizedBox(
            height: widget.height,
            child: PhysicalShape(
              clipper: clipper,
              elevation: elevation,
              color: effectiveColor,
              clipBehavior: widget.clipBehavior,
              child: Material(
                key: materialKey,
                type: MaterialType.transparency,
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          widget.expandableBottomBarDetails.items.length == 3
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.spaceEvenly,
                      children: widget.expandableBottomBarDetails.items
                          .asMap()
                          .entries
                          .map((entry) {
                        final int index = entry.key;
                        final BottomBarItem? itemDetails = entry.value;
                        final bool isActive = activeIndex == index;
                        // if (itemslength == 2 && entry.key == 1) {
                        //   return const Spacer();
                        // }
                        // if (itemslength == 4 && entry.key == 2) {
                        //   return const Spacer();
                        // }
                        return Flexible(
                          child: itemDetails != null
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                    itemDetails.onPressed();
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(
                                          isActive
                                              ? itemDetails.activeIcon ??
                                                  itemDetails.icon
                                              : itemDetails.icon,
                                          color: isActive
                                              ? activeIconTheme.color
                                              : iconTheme.color,
                                          size: isActive
                                              ? activeIconTheme.size
                                              : iconTheme.size,
                                        ),
                                        itemDetails.title != null
                                            ? Text(itemDetails.title ?? "",
                                                style: isActive
                                                    ? activeTextStyle
                                                    : textStyle)
                                            : const Center()
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: widget.floatingbuttonsize +
                                      widget.notchMargin,
                                ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    required this.geometry,
    required this.shape,
    required this.materialKey,
    required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null),
        super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final GlobalKey materialKey;
  final double notchMargin;
  // Returns the top of the BottomAppBar in global coordinates.
  //
  // If the Scaffold's bottomNavigationBar was specified, then we can use its
  // geometry value, otherwise we compute the location based on the AppBar's
  // Material widget.
  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) return bottomNavigationBarTop;
    final RenderBox? box =
        materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  double? buttonsize() {
    return geometry.value.floatingActionButtonArea
        ?.translate(0.0, bottomNavigationBarTop * -1)
        .height;
  }

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect? button = geometry.value.floatingActionButtonArea
        ?.translate(0.0, bottomNavigationBarTop * -1);
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class ActionCircle extends StatefulWidget {
  final List<Item> circleItems;
  final Color color;
  final double radius;

  const ActionCircle(
      {Key? key,
      required this.color,
      required this.radius,
      required this.circleItems})
      : super(key: key);

  @override
  State<ActionCircle> createState() => _ActionCircleState();
}

class _ActionCircleState extends State<ActionCircle> {
  @override
  Widget build(BuildContext context) {
    final double radianGap = 3.14159 / widget.circleItems.length;
    final double start = radianGap / 2;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: widget.circleItems.asMap().entries.map((entry) {
        final Item value = entry.value;

        return Transform.translate(
            offset: Offset.fromDirection(
                -(start + (entry.key * radianGap)), widget.radius / 2),
            child: GestureDetector(
              onTap: value.onPressed,
              // onTap: value.onPressed,
              child: value.icon,
            ));
      }).toList(),
    );
  }

// _buildbutton(double angle) {
//   final double rad = radians(angle);
//   return Transform(
//     transform: Matrix4.identity()
//       ..translate(
//         // (translation.value) *
//         math.cos(rad),
//         // (translation.value) *
//         math.sin(rad),
//       ),
//     child: Icon(Icons.ac_unit),
//   );
// }
}

double radians(double angle) {
  // degrees × π / 180°
  return (angle * math.pi) / 180;
}
