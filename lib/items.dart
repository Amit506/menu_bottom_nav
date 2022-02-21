import 'package:flutter/material.dart';

class BottomBarDetails {
  List<Color>? circleColors;
  IconThemeData? activeIconTheme;
  IconThemeData? iconTheme;
  TextStyle? activeTitleStyle;
  TextStyle? titleStyle;
  List<BottomBarItem?> items;
  List<Item> circleItems;

  BottomBarDetails(
      {required this.items,
      required this.circleItems,
      this.circleColors,
      this.activeIconTheme,
      this.iconTheme,
      this.activeTitleStyle,
      this.titleStyle})
      : assert(items.length == 2 || items.length == 4);
}

class Item {
  Icon icon;
  void Function() onPressed;

  Item({required this.icon, required this.onPressed});
}

class BottomBarItem {
  IconData? activeIcon;

  /// Icon data
  IconData icon;

  /// icon with title optional
  String? title;
  Function onPressed;

  BottomBarItem(
      {this.activeIcon,
      required this.icon,
      this.title,
      required this.onPressed});
}
