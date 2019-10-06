import 'package:flutter/material.dart';

class FriesPage {
  String title;
  IconData icon;

  FriesPage({
    this.title,
    this.icon,
  });

  static List<FriesPage> pages = [
    FriesPage(
      icon: Icons.swap_vertical_circle,
      title: "Quick Settings",
    ),
    FriesPage(
      icon: Icons.space_bar,
      title: "Status bar",
    ),
    FriesPage(
      icon: Icons.colorize,
      title: "Themes",
    ),
    FriesPage(
      icon: Icons.touch_app,
      title: "Buttons and navigation",
    ),
  ];
}