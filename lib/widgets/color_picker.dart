import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final bool lightnessLocked;
  final Function onApply;
  final Function onChange;
  final String title;

  ColorPicker({
    this.lightnessLocked = false,
    this.onApply,
    this.title = 'Color picker',
    this.onChange,
  });

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
                      String dark = HSLColor.fromAHSL(1, hue, saturation, 0.4)
                          .toColor()
                          .value
                          .toRadixString(16)
                          .substring(2, 8);
                      String light = HSLColor.fromAHSL(1, hue, saturation, 0.6)
                          .toColor()
                          .value
                          .toRadixString(16)
                          .substring(2, 8);
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
          Container(
            height: MediaQuery.of(context).size.height / 12,
            decoration: BoxDecoration(
              color: HSLColor.fromAHSL(1, hue, saturation, lightness).toColor(),
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
                  color: lightness > 0.5
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
                            HSLColor.fromAHSL(1, hue, saturation, 0.4)
                                .toColor(),
                      ),
                      Chip(
                        label: Text(
                          'Dark',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor:
                            HSLColor.fromAHSL(1, hue, saturation, 0.6)
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
