import 'dart:math' as math;

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/methods.dart';

class ColorPickerDualTile extends StatefulWidget {
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
  final bool hasDiscoSetting;

  ColorPickerDualTile({
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
    this.hasDiscoSetting = false,
  });

  @override
  _ColorPickerDualTileState createState() => _ColorPickerDualTileState();
}

class _ColorPickerDualTileState extends State<ColorPickerDualTile> {
  Color dark;
  Color light;
  bool discoReady;

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
      onTap: () => showColorPickerDual(
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
        hasDiscoSetting: widget.hasDiscoSetting,
      ),
    );
  }
}

class ColorPickerDual extends StatefulWidget {
  final bool lightnessLocked;
  final Function onApply;
  final Function onChange;
  final String title;
  final double lightnessMin;
  final double lightnessMax;
  final double lightnessDeltaCenter;
  final double lightnessDeltaEnd;

  final Color defaultDark;
  final Color defaultLight;
  final Color defaultColor;
  final bool hasDiscoSetting;

  ColorPickerDual({
    this.lightnessLocked = false,
    this.onApply,
    this.title = 'Color picker',
    this.onChange,
    this.lightnessMin = 0.0,
    this.lightnessMax = 1.0,
    this.lightnessDeltaCenter = 0.0,
    this.lightnessDeltaEnd = 0.0,
    this.defaultDark,
    this.defaultLight,
    this.defaultColor,
    this.hasDiscoSetting = false,
  }) : assert(lightnessDeltaCenter + lightnessDeltaEnd <= 1);

  @override
  _ColorPickerDualState createState() => _ColorPickerDualState();
}

class DiscoSetting extends StatefulWidget {
  final bool isEnabled;
  final Function onTap;

  DiscoSetting({@required this.isEnabled, @required this.onTap});

  @override
  _DiscoSettingState createState() => _DiscoSettingState();
}

class _DiscoSettingState extends State<DiscoSetting>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: math.pi * 2).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void startAnim() => controller?.repeat();

  void stopAnim() => controller?.stop();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isEnabled ? startAnim() : stopAnim();
    return GestureDetector(
      onTap: widget.onTap,
      child: Transform.rotate(
        angle: animation.value,
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            gradient: SweepGradient(
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
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
      ),
    );
  }
}

class _ColorPickerDualState extends State<ColorPickerDual> {
  double hue = 0;
  double saturation = 0.5;
  double lightness = 0.5;
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  bool isDiscoEnabled = false;
  final discoProp = 'persist.sys.theme.accent_disco';

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        await updateDisco();
        setState(
          () {
            if (widget.defaultColor != null) {
              var c = HSLColor.fromColor(widget.defaultColor);
              hue = c.hue;
              saturation = c.saturation;
              lightness = c.lightness;
            } else {
              var d = HSLColor.fromColor(widget.defaultDark ?? Colors.white);
              var l = HSLColor.fromColor(widget.defaultLight ?? Colors.black);
              hue = d.hue;
              saturation = d.saturation;
              lightness = (d.lightness -
                      l.lightness -
                      widget.lightnessDeltaCenter) /
                  (1 - widget.lightnessDeltaEnd - widget.lightnessDeltaCenter);
              if (lightness > widget.lightnessMax) {
                lightness = widget.lightnessMax;
              } else if (lightness < widget.lightnessMin) {
                lightness = widget.lightnessMin;
              }
            }
            updateDisco();
          },
        );
      },
    );
    super.initState();
  }

  Future<void> updateDisco() async =>
      isDiscoEnabled = await AndroidFlutterSettings.getProp(discoProp) == "1";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      var temp = width;
      width = height;
      height = temp;
    }

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
    if (widget.onChange != null)
      widget.onChange(
        HSLColor.fromAHSL(1, hue, saturation, lightnessDark).toColor(),
        HSLColor.fromAHSL(1, hue, saturation, lightnessLight).toColor(),
        ctx: context,
      );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
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
                    Spacer(),
                    Visibility(
                      visible: widget.hasDiscoSetting,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DiscoSetting(
                          isEnabled: isDiscoEnabled,
                          onTap: () async {
                            AndroidFlutterSettings.setProp(
                                discoProp, isDiscoEnabled ? "0" : "1");
                            await updateDisco();
                            setState(() {});
                            reloadSystemElements();
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.onApply != null,
                      child: FloatingActionButton(
                        elevation: 0,
                        mini: true,
                        child: Icon(
                          widget.hasDiscoSetting && isDiscoEnabled
                              ? Icons.close
                              : Icons.check,
                          color: HSLColor.fromAHSL(1, hue, saturation, 0.85)
                              .toColor(),
                        ),
                        onPressed: widget.hasDiscoSetting && isDiscoEnabled
                            ? () => Navigator.of(context).pop()
                            : () {
                                String dark = HSLColor.fromAHSL(
                                  1,
                                  hue,
                                  saturation,
                                  lightnessDark,
                                )
                                    .toColor()
                                    .value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                String light = HSLColor.fromAHSL(
                                  1,
                                  hue,
                                  saturation,
                                  lightnessLight,
                                )
                                    .toColor()
                                    .value
                                    .toRadixString(16)
                                    .substring(2, 8);
                                widget.onApply(dark, light);
                                Navigator.of(context).pop();
                              },
                        backgroundColor:
                            HSLColor.fromAHSL(1, hue, saturation, 0.5)
                                .toColor(),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: widget.hasDiscoSetting && isDiscoEnabled ? 0.5 : 1.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: IgnorePointer(
                  ignoring: widget.hasDiscoSetting && isDiscoEnabled,
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: widget.lightnessLocked ||
                            (widget.lightnessDeltaEnd == 0 &&
                                widget.lightnessDeltaCenter == 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            color: HSLColor.fromAHSL(
                                    1, hue, saturation, lightnessNeutral)
                                .toColor(),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              '#' +
                                  HSLColor.fromAHSL(
                                          1, hue, saturation, lightnessNeutral)
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
                          height: orientation == Orientation.portrait
                              ? height / 12
                              : height / 10,
                          width: orientation == Orientation.landscape
                              ? width * 0.8
                              : double.infinity,
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
                            width: (width / 10) * 7,
                            child: Slider(
                              activeColor: HSLColor.fromAHSL(
                                      1, hue, saturation, lightnessNeutral)
                                  .toColor(),
                              inactiveColor: HSLColor.fromAHSL(
                                      0.25, hue, saturation, lightnessNeutral)
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
                            width: (width / 10) * 7,
                            child: Slider(
                              activeColor: HSLColor.fromAHSL(
                                      1, hue, saturation, lightnessNeutral)
                                  .toColor(),
                              inactiveColor: HSLColor.fromAHSL(
                                      0.25, hue, saturation, lightnessNeutral)
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
                              width: (width / 10) * 7,
                              child: Slider(
                                activeColor: HSLColor.fromAHSL(
                                        1, hue, saturation, lightnessNeutral)
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
                ),
              ),
            ],
          ),
        ),
      ],
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
