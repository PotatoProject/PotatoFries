import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class ColorPickerTile extends StatefulWidget {
  final Function onChange;
  final Function onApply;
  final double lightnessDeltaCenter;
  final double lightnessDeltaEnd;
  final double lightnessMin;
  final double lightnessMax;
  final bool lightnessLocked;
  final String title;
  final String subtitle;
  final Color defaultLight;
  final Color defaultDark;
  final Color defaultColor;

  ColorPickerTile({
    this.onChange,
    this.onApply,
    this.lightnessDeltaCenter = 0.0,
    this.lightnessDeltaEnd = 0.0,
    this.lightnessMin = 0.0,
    this.lightnessMax = 1.0,
    this.lightnessLocked = false,
    this.title,
    this.subtitle,
    this.defaultDark,
    this.defaultLight,
    this.defaultColor,
  });

  @override
  _ColorPickerTileState createState() => _ColorPickerTileState();
}

class _ColorPickerTileState extends State<ColorPickerTile> {
  Color dark;
  Color light;

  @override
  void initState() {
    dark = widget.defaultDark ?? widget.defaultColor;
    light = widget.defaultLight ?? widget.defaultColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizeableListTile(
      title: widget.title,
      subtitle: Text(widget.subtitle),
      icon: Row(
        children: <Widget>[
          Container(
            height: 24,
            width: 12,
            decoration: BoxDecoration(
              color: light ?? Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Container(
            height: 24,
            width: 12,
            decoration: BoxDecoration(
              color: dark ?? Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          )
        ],
      ),
      onTap: () => showColorPicker(
        context,
        onChange: (dark, light, {ctx}) {
          if (widget.onChange != null)
            widget.onChange(dark, light, ctx: ctx ?? context);
          Future.delayed(Duration.zero, () {
            if (mounted)
              setState(
                () {
                  this.dark = dark;
                  this.light = light;
                },
              );
          });
        },
        onApply: (String newDark, String newLight) {
          setState(() {
            dark = Color(int.parse('0xff' + newDark));
            light = Color(int.parse('0xff' + newLight));
          });
          if (widget.onApply != null) widget.onApply(newDark, newLight);
        },
        lightnessDeltaCenter: widget.lightnessDeltaCenter,
        lightnessDeltaEnd: widget.lightnessDeltaEnd,
        lightnessMin: widget.lightnessMin,
        lightnessMax: widget.lightnessMax,
        lightnessLocked: widget.lightnessLocked,
        defaultColor: widget.defaultColor,
        defaultDark: widget.defaultDark,
        defaultLight: widget.defaultLight,
      ),
    );
  }
}
