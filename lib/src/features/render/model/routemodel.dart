import 'package:flutter/material.dart';

class AppBottomBarItem {
  const AppBottomBarItem({
    required this.activeIcon,
    required this.title,
    this.showBadge = false,
    this.badgeColor = Colors.black,
    this.badge,
    this.backgroundColor,
    this.iconColor,
  });

  final String activeIcon;
  final String title;
  final bool showBadge;
  final Color badgeColor;
  final Widget? badge;
  final Color? backgroundColor;
  final Color? iconColor;
}
