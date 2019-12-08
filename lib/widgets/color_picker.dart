import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final bool lightnessLocked;
  final Function onApply;
  final Function onChange;
  final String title;
  final double lightnessMin;
  final double lightnessMax;
  final double lightnessDeltaCenter;
  final double lightnessDeltaEnd;

  ColorPicker({
    this.lightnessLocked = false,
    this.onApply,
    this.title = 'Color picker',
    this.onChange,
    this.lightnessMin = 0,
    this.lightnessMax = 1,
    this.lightnessDeltaCenter = 0,
    this.lightnessDeltaEnd = 0,
  })  : assert(lightnessDeltaCenter + lightnessDeltaEnd <= 1),
        assert(!lightnessLocked &&
            (lightnessDeltaCenter != 0 || lightnessDeltaEnd != 0));

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0;
  double saturation = 0.5;
  double lightness = 0.5;

  @override
  void setState(fn) {
    widget.onChange(HSLColor.fromAHSL(1, hue, saturation, lightness).toColor());
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    lightness = widget.lightnessLocked ? 0.5 : lightness;
    double lightnessLight = lightness;
    double lightnessDark = lightness;
    double lightnessNeutral = lightness;
    if (widget.lightnessDeltaEnd != 0 || widget.lightnessDeltaCenter != 0) {
      lightnessNeutral = 0.5;
      double absolute =
          (1 - widget.lightnessDeltaEnd - widget.lightnessDeltaCenter) *
              lightness /
              2;
      lightnessDark = (0.5 + widget.lightnessDeltaCenter / 2) + absolute;
      lightnessLight = (0.5 - widget.lightnessDeltaCenter / 2) - absolute;
    }
    return Padding(
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
                  style: Theme.of(context).textTheme.title,
                ),
                Visibility(
                  visible: widget.onApply != null,
                  child: FloatingActionButton(
                    elevation: 0,
                    mini: true,
                    child: Icon(
                      Icons.check,
                      color:
                          HSLColor.fromAHSL(1, hue, saturation, 0.85).toColor(),
                    ),
                    onPressed: () {
                      String dark = HSLColor.fromAHSL(
                        1,
                        hue,
                        saturation,
                        lightnessDark,
                      ).toColor().value.toRadixString(16).substring(2, 8);
                      String light = HSLColor.fromAHSL(
                        1,
                        hue,
                        saturation,
                        lightnessLight,
                      ).toColor().value.toRadixString(16).substring(2, 8);
                      widget.onApply(dark, light);
                      Navigator.of(context).pop();
                    },
                    backgroundColor:
                        HSLColor.fromAHSL(1, hue, saturation, 0.5).toColor(),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.lightnessLocked ||
                (widget.lightnessDeltaEnd == 0 &&
                    widget.lightnessDeltaCenter == 0),
            child: Container(
              height: MediaQuery.of(context).size.height / 12,
              decoration: BoxDecoration(
                color: HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                    .toColor(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '#' +
                      HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                          .toColor()
                          .value
                          .toRadixString(16)
                          .substring(2, 8),
                  style: TextStyle(
                    color: lightnessNeutral > 0.5
                        ? Colors.black.withOpacity(0.70)
                        : Colors.white.withOpacity(0.70),
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.lightnessDeltaEnd != 0 ||
                widget.lightnessDeltaCenter != 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  accentPreview(
                    lightnessLight,
                    'Light',
                    BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  accentPreview(
                    lightnessDark,
                    'Dark',
                    BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ],
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
                      HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                          .toColor(),
                  inactiveColor:
                      HSLColor.fromAHSL(0.25, hue, saturation, lightnessNeutral)
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
                      HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                          .toColor(),
                  inactiveColor:
                      HSLColor.fromAHSL(0.25, hue, saturation, lightnessNeutral)
                          .toColor(),
                  value: saturation,
                  min: 0,
                  max: 1,
                  onChanged: (d) => setState(() => saturation = d),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !widget.lightnessLocked,
            child: Row(
              children: <Widget>[
                Text('Lightness'),
                Spacer(),
                Container(
                  width: (MediaQuery.of(context).size.width / 10) * 7,
                  child: Slider(
                    activeColor:
                        HSLColor.fromAHSL(1, hue, saturation, lightnessNeutral)
                            .toColor(),
                    inactiveColor: HSLColor.fromAHSL(
                            0.25, hue, saturation, lightnessNeutral)
                        .toColor(),
                    value: lightness,
                    min: widget.lightnessMin,
                    max: widget.lightnessMax,
                    onChanged: (d) => setState(() => lightness = d),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget accentPreview(
    double lightness,
    String title,
    BorderRadius borderRadius,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: HSLColor.fromAHSL(1, hue, saturation, lightness).toColor(),
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                '#' +
                    HSLColor.fromAHSL(1, hue, saturation, lightness)
                        .toColor()
                        .value
                        .toRadixString(16)
                        .substring(2, 8),
                style: TextStyle(
                  color: lightness > 0.5
                      ? Colors.black.withOpacity(0.70)
                      : Colors.white.withOpacity(0.70),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: lightness > 0.5
                          ? Colors.black.withOpacity(0.40)
                          : Colors.white.withOpacity(0.40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
