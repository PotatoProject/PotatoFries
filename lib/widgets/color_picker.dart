import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/methods.dart';

class ColorPickerTile extends StatefulWidget {
  final Function onApply;
  final String title;
  final String subtitle;
  final Color defaultColor;
  final Function getColor;
  final double lightnessMin;
  final double lightnessMax;
  final bool showUnsetPreview;

  ColorPickerTile({
    this.onApply,
    this.title,
    this.subtitle,
    this.defaultColor,
    this.getColor,
    this.lightnessMin = 0,
    this.lightnessMax = 1,
    this.showUnsetPreview = false,
  });

  @override
  _ColorPickerTileState createState() => _ColorPickerTileState();
}

class _ColorPickerTileState extends State<ColorPickerTile> {
  Color color;

  @override
  Widget build(BuildContext context) {
    var acquiredColor = widget.getColor();
    color = acquiredColor ?? widget.defaultColor ?? Colors.transparent;
    return SizeableListTile(
      title: widget.title,
      subtitle: Text(widget.subtitle),
      icon: Row(
        children: <Widget>[
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: (widget.showUnsetPreview && acquiredColor == null)
                  ? null
                  : color,
              gradient: !(widget.showUnsetPreview && acquiredColor == null)
                  ? null
                  : SweepGradient(
                      colors: [
                        Colors.red,
                        Colors.purpleAccent,
                        Colors.blue,
                        Colors.cyan,
                        Colors.green,
                        Colors.yellow,
                        Colors.red,
                      ],
                      tileMode: TileMode.clamp,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ],
      ),
      onTap: () => showColorPicker(
        context,
        onApply: widget.onApply,
        defaultColor: color,
        lightnessMin: widget.lightnessMin,
        lightnessMax: widget.lightnessMax,
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Function onApply;
  final String title;
  final double lightnessMin;
  final double lightnessMax;
  final Color defaultColor;

  ColorPicker({
    this.onApply,
    this.title = 'Color picker',
    this.lightnessMin = 0,
    this.lightnessMax = 1,
    this.defaultColor,
  });

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0;
  double saturation = 0.5;
  double lightness = 0.5;

  @override
  void initState() {
    var c = HSLColor.fromColor(widget.defaultColor);
    Future.delayed(Duration.zero, () {
      hue = c.hue;
      saturation = c.saturation;
      lightness = c.lightness;
      if (lightness < widget.lightnessMin) lightness = widget.lightnessMin;
      if (lightness > widget.lightnessMax) lightness = widget.lightnessMax;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Visibility(
                    visible: widget.onApply != null,
                    child: FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      child: Icon(
                        Icons.check,
                        color: lightness > 0.6 ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        Color c =
                            HSLColor.fromAHSL(1, hue, saturation, lightness)
                                .toColor();
                        widget.onApply(c);
                        Navigator.of(context).pop();
                      },
                      backgroundColor:
                          HSLColor.fromAHSL(1, hue, saturation, lightness)
                              .toColor(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                color:
                    HSLColor.fromAHSL(1, hue, saturation, lightness).toColor(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '#' +
                      HSLColor.fromAHSL(1, hue, saturation, lightness)
                          .toColor()
                          .value
                          .toRadixString(16)
                          .substring(2, 8),
                  style: TextStyle(
                    color: lightness > 0.6
                        ? Colors.black.withOpacity(0.70)
                        : Colors.white.withOpacity(0.70),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text('Hue'),
                Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width / 10) * 7,
                  child: Slider(
                    activeColor:
                        HSLColor.fromAHSL(1, hue, saturation, lightness)
                            .toColor(),
                    inactiveColor:
                        HSLColor.fromAHSL(0.25, hue, saturation, lightness)
                            .toColor(),
                    value: hue,
                    min: 0,
                    max: 360,
                    onChanged: (d) => setState(() => hue = d),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text('Saturation'),
                Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width / 10) * 7,
                  child: Slider(
                    activeColor:
                        HSLColor.fromAHSL(1, hue, saturation, lightness)
                            .toColor(),
                    inactiveColor:
                        HSLColor.fromAHSL(0.25, hue, saturation, lightness)
                            .toColor(),
                    value: saturation,
                    min: 0,
                    max: 1,
                    onChanged: (d) => setState(() => saturation = d),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Lightness'),
                Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width / 10) * 7,
                  child: Slider(
                    activeColor:
                        HSLColor.fromAHSL(1, hue, saturation, lightness)
                            .toColor(),
                    inactiveColor:
                        HSLColor.fromAHSL(0.25, hue, saturation, lightness)
                            .toColor(),
                    value: lightness,
                    min: widget.lightnessMin,
                    max: widget.lightnessMax,
                    onChanged: (d) => setState(() => lightness = d),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
