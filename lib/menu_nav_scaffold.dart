import 'menu_bottom_nav.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MenuNavScaffold extends StatefulWidget {
  const MenuNavScaffold(
      {Key? key,
      this.appBar,
      this.floatingButtonColor,
      this.body,
      this.persistentFooterButtons,
      this.drawer,
      this.onDrawerChanged,
      this.endDrawer,
      this.onEndDrawerChanged,
      required this.bottomBarDetails,
      this.bottomSheet,
      this.backgroundColor,
      this.resizeToAvoidBottomInset,
      this.primary = true,
      this.drawerDragStartBehavior = DragStartBehavior.start,
      this.extendBodyBehindAppBar = false,
      this.drawerScrimColor,
      this.drawerEdgeDragWidth,
      this.drawerEnableOpenDragGesture = true,
      this.endDrawerEnableOpenDragGesture = true,
      this.notchMargin = 10.0,
      this.strokewidth,
      this.floatingbuttonsize = 60,
      this.strokeColor,
      this.bottomBarColor,
      this.activefloatingIcon,
      this.cancelMenuFloatingIcon,
      this.navHeight = 60})
      : assert(navHeight >= 60 && notchMargin >= 8.0),
        super(key: key);
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;

  /// navigation bar height
  final double navHeight;

  /// bottombar details
  final BottomBarDetails bottomBarDetails;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;

  /// floating button size
  final double floatingbuttonsize;
  final bool endDrawerEnableOpenDragGesture;

  /// ring width
  final double? strokewidth;

  /// cancel circular widget
  final Widget? cancelMenuFloatingIcon;

  /// floating wodget when circular widget is hidden
  final Widget? activefloatingIcon;

  /// notch margin
  final double notchMargin;

  /// circular ring  color
  final Color? strokeColor;

  /// floating button color
  final Color? floatingButtonColor;
  final Color? bottomBarColor;

  @override
  _MenuNavScaffoldState createState() => _MenuNavScaffoldState();
}

class _MenuNavScaffoldState extends State<MenuNavScaffold> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: widget.appBar,
      body: widget.body,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: widget.primary,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: true,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IgnorePointer(
        ignoring: true,
        child: SizedBox(
          height: widget.floatingbuttonsize,
          width: widget.floatingbuttonsize,
          child: FloatingActionButton(
            splashColor: Colors.transparent,
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.add,
              color: Colors.transparent,
            ),
            onPressed: () {
              // print('floating button used');
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        onTapMenuButton: () async {
          setState(() {
            open = !open;
          });
        },
        activefloatingIcon: widget.activefloatingIcon,
        cancelMenuFloatingIcon: widget.cancelMenuFloatingIcon,
        floatingbuttonsize: widget.floatingbuttonsize,
        height: widget.navHeight,
        shouldOpen: open,
        color: widget.bottomBarColor,
        expandableBottomBarDetails: widget.bottomBarDetails,
        shape: CustomNotch(),
        storkeWidth: widget.strokewidth,
        notchMargin: widget.notchMargin,
        strokeColor: widget.strokeColor,
        floatingButtonColor: widget.floatingButtonColor,
      ),
    );
  }
}
