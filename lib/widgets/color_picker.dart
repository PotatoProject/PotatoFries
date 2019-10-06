import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final bool lightnessLocked;

  ColorPicker({this.lightnessLocked = false});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0;
  double saturation = 0.5;
  double lightness = 0.5;

  @override
  Widget build(BuildContext context) {
    lightness = widget.lightnessLocked ? 0.5 : lightness;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            color: HSLColor.fromAHSL(1, hue, saturation, lightness).toColor(),
            child: Center(
              child: Text(
                '#' +
                    HSLColor.fromAHSL(1, hue, saturation, lightness)
                        .toColor()
                        .value
                        .toRadixString(16),
                style: TextStyle(
                  color: lightness > 0.5
                      ? Colors.black.withOpacity(0.70)
                      : Colors.white.withOpacity(0.70),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Text('Hue'),
              Expanded(
                child: Slider(
                  activeColor: HSLColor.fromAHSL(1, hue, saturation, lightness)
                      .toColor(),
                  inactiveColor:
                      HSLColor.fromAHSL(0.25, hue, saturation, lightness)
                          .toColor(),
                  value: hue,
                  min: 0,
                  max: 360,
                  onChanged: (d) => setState(() => hue = d),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Saturation'),
              Expanded(
                child: Slider(
                  activeColor: HSLColor.fromAHSL(1, hue, saturation, lightness)
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
          Visibility(
            visible: !widget.lightnessLocked,
            child: Row(
              children: <Widget>[
                Text('Lightness'),
                Expanded(
                  child: Slider(
                    activeColor:
                        HSLColor.fromAHSL(1, hue, saturation, lightness)
                            .toColor(),
                    inactiveColor:
                        HSLColor.fromAHSL(0.25, hue, saturation, lightness)
                            .toColor(),
                    value: lightness,
                    min: 0,
                    max: 1,
                    onChanged: (d) => setState(() => lightness = d),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.lightnessLocked,
            child: Row(
              children: <Widget>[
                Text("Adjusted Colors"),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Chip(
                        label: Text(
                          'Light',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            HSLColor.fromAHSL(1, hue, saturation, 0.45)
                                .toColor(),
                      ),
                      Chip(
                        label: Text(
                          'Dark',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor:
                            HSLColor.fromAHSL(1, hue, saturation, 0.55)
                                .toColor(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
