import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Widget> items;
  final Color backgroundColor;
  final Color selectedColor;
  final EdgeInsets padding;

  CustomBottomBar({
    this.currentIndex = 0,
    this.onTap,
    @required this.items,
    this.backgroundColor,
    this.selectedColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
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
    for (Widget item in items) {
      widgets.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: currentIndex == items.indexOf(item) ? 8.0 : 0,
          ),
          child: IconButton(
            icon: item,
            color: currentIndex == items.indexOf(item)
                ? selectedColor ?? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color.withOpacity(0.4),
            onPressed: () => onTap == null ? {} : onTap(items.indexOf(item)),
            iconSize: currentIndex == items.indexOf(item) ? 32 : 24,
          ),
        ),
      );
    }
    return widgets;
  }
}
