import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Widget> items;
  final Color backgroundColor;
  final Color selectedColor;
  final EdgeInsets padding;

  CustomBottomBar({
    this.currentIndex,
    this.onTap,
    @required this.items,
    this.backgroundColor,
    this.selectedColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: barBuilder(context),
        ),
      ),
    );
  }

  List<Widget> barBuilder(BuildContext context) {
    List<Widget> widgets = [];

    for(int i = 0; i < items.length; i++) {
      widgets.add(
        IconButton(
          icon: items[i],
          color: currentIndex == i ? selectedColor ?? Theme.of(context).accentColor : Theme.of(context).iconTheme.color.withOpacity(0.4),
          onPressed: () => onTap(i),
        ),
      );
    }

    return widgets;
  }
}