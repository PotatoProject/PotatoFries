import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/animated_disable.dart';
import 'package:potato_fries/widgets/disco_spinner.dart';
import 'package:provider/provider.dart';

class MultiModeColorPickerDual extends StatefulWidget {
  final Color lightColor;
  final Color darkColor;
  final PickerMode mode;
  final double tolerance;
  final void Function(Color light, Color dark) onColorChanged;

  MultiModeColorPickerDual({
    @required this.lightColor,
    @required this.darkColor,
    this.mode = PickerMode.RGB,
    this.onColorChanged,
    @required this.tolerance,
  });

  @override
  _MultiModeColorPickerDualState createState() =>
      _MultiModeColorPickerDualState();
}

class _MultiModeColorPickerDualState extends State<MultiModeColorPickerDual> {
  final lightController = TextEditingController();
  final darkController = TextEditingController();
  dynamic lightColor;
  dynamic darkColor;

  bool editDarkColor = false;

  dynamic get color => editDarkColor ? darkColor : lightColor;

  @override
  void initState() {
    _updateColor(widget.lightColor, widget.darkColor, autoCalc: false);
    super.initState();
  }

  @override
  void didUpdateWidget(MultiModeColorPickerDual old) {
    final newLightColor =
        widget.lightColor != old.lightColor ? widget.lightColor : lightColor;
    final newDarkColor =
        widget.darkColor != old.darkColor ? widget.darkColor : darkColor;

    _updateColor(newLightColor, newDarkColor);

    super.didUpdateWidget(old);
  }

  void _updateColor(dynamic newLightColor, dynamic newDarkColor,
      {bool autoCalc = true}) {
    switch (widget.mode) {
      case PickerMode.RGB:
        if (newLightColor is Color) {
          lightColor = newLightColor;
        } else {
          lightColor = newLightColor.toColor();
        }

        if (newDarkColor is Color) {
          darkColor = newDarkColor;
        } else {
          darkColor = newDarkColor.toColor();
        }

        break;
      case PickerMode.HSL:
        if (newLightColor is Color) {
          lightColor = HSLColor.fromColor(newLightColor);
        } else if (newLightColor is HSVColor) {
          lightColor = HSLColor.fromColor(newLightColor.toColor());
        } else {
          lightColor = newLightColor;
        }

        if (newDarkColor is Color) {
          darkColor = HSLColor.fromColor(newDarkColor);
        } else if (newDarkColor is HSVColor) {
          darkColor = HSLColor.fromColor(newDarkColor.toColor());
        } else {
          darkColor = newDarkColor;
        }

        break;
      case PickerMode.HSV:
        if (newLightColor is Color) {
          lightColor = HSVColor.fromColor(newLightColor);
        } else if (newLightColor is HSLColor) {
          lightColor = HSVColor.fromColor(newLightColor.toColor());
        } else {
          lightColor = newLightColor;
        }

        if (newDarkColor is Color) {
          darkColor = HSVColor.fromColor(newDarkColor);
        } else if (newDarkColor is HSLColor) {
          darkColor = HSVColor.fromColor(newDarkColor.toColor());
        } else {
          darkColor = newDarkColor;
        }
        break;
    }

    if (autoCalc && context.read<AppInfoProvider>().autoCalculateAccents) {
      var cHSL;
      var workingColor = editDarkColor ? darkColor : lightColor;
      switch (workingColor.runtimeType) {
        case HSVColor:
          cHSL = HSLColor.fromColor(workingColor.toColor());
          break;
        case HSLColor:
          cHSL = workingColor;
          break;
        default:
          cHSL = HSLColor.fromColor(workingColor);
          break;
      }
      workingColor = cHSL.withLightness(1 - cHSL.lightness);
      switch (widget.mode) {
        case PickerMode.RGB:
          workingColor = workingColor.toColor();
          break;
        case PickerMode.HSV:
          workingColor = HSVColor.fromColor(workingColor.toColor());
          break;
        case PickerMode.HSL:
        default:
          break;
      }
      if (!editDarkColor) {
        darkColor = workingColor;
      } else {
        lightColor = workingColor;
      }
    }

    _updateControllerText();
  }

  void _updateControllerText() {
    lightController.text =
        getLightColor().value.toRadixString(16).substring(2, 8).toUpperCase();
    darkController.text =
        getDarkColor().value.toRadixString(16).substring(2, 8).toUpperCase();
  }

  Color getLightColor() {
    if (lightColor is Color)
      return lightColor.withAlpha(0xff);
    else
      return lightColor.toColor().withAlpha(0xff);
  }

  Color getDarkColor() {
    if (darkColor is Color)
      return darkColor.withAlpha(0xff);
    else
      return darkColor.toColor().withAlpha(0xff);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sliders;

    switch (widget.mode) {
      case PickerMode.RGB:
        sliders = rgbSliders;
        break;
      case PickerMode.HSL:
        sliders = hslSliders;
        break;
      case PickerMode.HSV:
        sliders = hsvSliders;
        break;
    }

    sliders = List.generate(
      (2 * sliders.length) - 1,
      (index) {
        if (index % 2 == 0) {
          return sliders[index ~/ 2];
        } else {
          return Spacer();
        }
      },
    );

    final appInfo = context.watch<AppInfoProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDisable(
          disabled: appInfo.discoEasterActive,
          child: Container(
            height: 100,
            margin: EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: _ColorDisplay(
                    color: getLightColor(),
                    controller: lightController,
                    onChanged: (text) {
                      if (text.length == 6) {
                        Color newColor = Color(int.parse(text, radix: 16));
                        _updateColor(newColor, darkColor);
                        widget.onColorChanged
                            ?.call(getLightColor(), getDarkColor());
                        setState(() {});
                      }
                    },
                    onPressed: () => setState(() => editDarkColor = false),
                    selected: !editDarkColor,
                    tolerance: widget.tolerance,
                    isColorDark: false,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _ColorDisplay(
                    color: getDarkColor(),
                    controller: darkController,
                    onChanged: (text) {
                      if (text.length == 6) {
                        Color newColor = Color(int.parse(text, radix: 16));
                        _updateColor(lightColor, newColor);
                        widget.onColorChanged
                            ?.call(getLightColor(), getDarkColor());
                        setState(() {});
                      }
                    },
                    onPressed: () => setState(() => editDarkColor = true),
                    selected: editDarkColor,
                    tolerance: widget.tolerance,
                    isColorDark: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedDisable(
          disabled: appInfo.discoEasterActive,
          child: Row(
            children: [
              Spacer(),
              ActionChip(
                label: Text(
                  LocaleStrings.themes.themesSystemAccentLightColorTitle,
                ),
                backgroundColor: !editDarkColor
                    ? Theme.of(context).chipTheme.backgroundColor
                    : Theme.of(context).cardColor,
                onPressed: () => setState(() => editDarkColor = false),
              ),
              Spacer(flex: 2),
              ActionChip(
                label: Text(
                  LocaleStrings.themes.themesSystemAccentDarkColorTitle,
                ),
                backgroundColor: editDarkColor
                    ? Theme.of(context).chipTheme.backgroundColor
                    : Theme.of(context).cardColor,
                onPressed: () => setState(() => editDarkColor = true),
              ),
              Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedDisable(
                disabled: appInfo.discoEasterActive,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleStrings
                        .themes.themesSystemAccentCalculateShadesLabel),
                    Switch(
                      onChanged: (b) => setState(() => context
                          .read<AppInfoProvider>()
                          .autoCalculateAccents = b),
                      value:
                          context.watch<AppInfoProvider>().autoCalculateAccents,
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
              appInfo.discoEasterEnabled
                  ? DiscoSpinner(
                      isSpinning: appInfo.discoEasterActive,
                      onTap: () => appInfo.discoEasterActive =
                          !appInfo.discoEasterActive,
                    )
                  : Container(),
            ],
          ),
        ),
        AnimatedDisable(
          disabled: appInfo.discoEasterActive,
          child: SizedBox(
            height: 150,
            child: Column(
              children: [
                Spacer(),
                ...sliders,
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get rgbSliders => [
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withRed(value.toInt());
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.red.toDouble(),
          max: 255,
          type: _SliderType.RED,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withGreen(value.toInt());
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.green.toDouble(),
          max: 255,
          type: _SliderType.GREEN,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withBlue(value.toInt());
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.blue.toDouble(),
          max: 255,
          type: _SliderType.BLUE,
        ),
      ];

  List<Widget> get hslSliders => [
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withHue(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.hue,
          max: 360,
          type: _SliderType.HUE,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withSaturation(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.saturation,
          type: _SliderType.SATURATION,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withLightness(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.lightness,
          type: _SliderType.LIGHTNESS,
        ),
      ];

  List<Widget> get hsvSliders => [
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withHue(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.hue,
          max: 360,
          type: _SliderType.HUE,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withSaturation(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.saturation,
          type: _SliderType.SATURATION,
        ),
        _PickerSlider(
          color: color,
          onValueChanged: (value) {
            final newColor = color.withValue(value);
            _updateColor(
              editDarkColor ? getLightColor() : newColor,
              editDarkColor ? newColor : getDarkColor(),
            );
            widget.onColorChanged?.call(getLightColor(), getDarkColor());
            setState(() {});
          },
          value: color.value,
          type: _SliderType.VALUE,
        ),
      ];
}

class _ColorDisplay extends StatelessWidget {
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onPressed;
  final bool selected;
  final double tolerance;
  final bool isColorDark;
  final selectorDelta = 0.2;

  _ColorDisplay({
    @required this.color,
    @required this.controller,
    @required this.onChanged,
    @required this.onPressed,
    @required this.tolerance,
    this.selected = false,
    this.isColorDark = false,
  });

  @override
  Widget build(BuildContext context) {
    // var hslColor = HSLColor.fromColor(color);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  /*selected
                      ? hslColor
                          .withLightness(hslColor.lightness < selectorDelta
                              ? hslColor.lightness - (hslColor.lightness) / 2
                              : hslColor.lightness - selectorDelta)
                          .toColor()
                      : */
                  Colors.transparent,
              // color: selected
              //     ? HSLColor.fromColor(color).lightness > 1 - tolerance
              //         ? !isColorDark
              //             ? Colors.red
              //             : Colors.black
              //         : isColorDark
              //             ? Colors.red
              //             : Colors.white
              //     : Colors.transparent,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: color,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Center(
                child: IntrinsicWidth(
                  child: TextField(
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("[0-9|A-F|a-f]"),
                      ),
                      LengthLimitingTextInputFormatter(6),
                    ],
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (HSLColor.fromColor(color).lightness > 0.5
                                  ? Colors.black
                                  : Colors.white)
                              .withOpacity(0.6),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: (HSLColor.fromColor(color).lightness > 0.5
                                  ? Colors.black
                                  : Colors.white)
                              .withOpacity(0.6),
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      prefixText: "# ",
                      prefixStyle: TextStyle(
                        color: (HSLColor.fromColor(color).lightness > 0.5
                                ? Colors.black
                                : Colors.white)
                            .withOpacity(0.6),
                      ),
                    ),
                    style: TextStyle(
                      color: HSLColor.fromColor(color).lightness > 0.5
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Visibility(
            visible: isColorDark
                ? HSLColor.fromColor(color).lightness < tolerance
                    ? true
                    : false
                : HSLColor.fromColor(color).lightness > 1 - tolerance
                    ? true
                    : false,
            // HSLColor.fromColor(color).lightness > 1 - tolerance
            //     ? !isColorDark
            //         ? true
            //         : false
            //     : isColorDark
            //         ? true
            //         : false,
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

const double _kThumbRadius = 10;
const double _kTrackHeight = 6;

class _PickerSlider extends StatefulWidget {
  final dynamic color;
  final double value;
  final double max;
  final ValueChanged<double> onValueChanged;
  final _SliderType type;

  _PickerSlider({
    @required this.color,
    @required this.value,
    this.max = 1.0,
    @required this.type,
    this.onValueChanged,
  })  : assert(color is Color || color is HSLColor || color is HSVColor),
        assert(value <= max);

  @override
  _PickerSliderState createState() => _PickerSliderState();
}

class _PickerSliderState extends State<_PickerSlider>
    with SingleTickerProviderStateMixin {
  AnimationController _ac;

  @override
  void initState() {
    _ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _curvedAc = CurvedAnimation(
      parent: _ac,
      curve: decelerateEasing,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return GestureDetector(
            onHorizontalDragDown: (details) {
              _ac.forward();
              onGestureUpdate(
                details.localPosition.dx,
                width,
              );
            },
            onHorizontalDragCancel: () => _ac.reverse(),
            onHorizontalDragEnd: (details) => _ac.reverse(),
            onHorizontalDragUpdate: (details) => onGestureUpdate(
              details.localPosition.dx,
              width,
            ),
            child: AnimatedBuilder(
              animation: _ac,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(width, 40),
                  painter: TrackPainter(widget.color, widget.type),
                  foregroundPainter: ThumbPainter(
                    widget.value / widget.max,
                    widget.max,
                    widget.color,
                    widget.type,
                    _curvedAc.value,
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.grey[900],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void onGestureUpdate(double dx, double width) {
    dx = dx - _kThumbRadius;
    width = width - _kThumbRadius * 2;

    final newValue = (dx / width) * widget.max;
    widget.onValueChanged?.call(newValue.clamp(0.0, widget.max));
  }
}

class TrackPainter extends CustomPainter {
  final dynamic color;
  final _SliderType type;

  TrackPainter(
    this.color,
    this.type,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      _kThumbRadius,
      size.height / 2 - _kTrackHeight / 2,
      size.width - _kThumbRadius * 2,
      _kTrackHeight,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(_kTrackHeight));

    canvas.clipRRect(rrect);

    List<Color> colors;
    bool useValue = color is HSVColor;

    switch (type) {
      case _SliderType.HUE:
        colors = [
          HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
        ];
        break;
      case _SliderType.SATURATION:
        colors = [
          Colors.white,
          if (useValue)
            HSVColor.fromAHSV(1, color.hue, 1, color.value).toColor()
          else
            HSLColor.fromAHSL(1, color.hue, 1, color.lightness).toColor(),
        ];
        break;
      case _SliderType.LIGHTNESS:
        colors = [
          Colors.black,
          HSLColor.fromAHSL(1, color.hue, color.saturation, 0.5).toColor(),
          Colors.white,
        ];
        break;
      case _SliderType.VALUE:
        colors = [
          Colors.black,
          HSVColor.fromAHSV(1, color.hue, color.saturation, 1).toColor(),
        ];
        break;
      case _SliderType.RED:
        colors = [
          Colors.black,
          Color.fromRGBO(0xff, 0, 0, 1),
        ];
        break;
      case _SliderType.GREEN:
        colors = [
          Colors.black,
          Color.fromRGBO(0, 0xff, 0, 1),
        ];
        break;
      case _SliderType.BLUE:
        colors = [
          Colors.black,
          Color.fromRGBO(0, 0, 0xff, 1),
        ];
        break;
    }

    final gradient = LinearGradient(
      colors: colors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    final trackPath = new Path();
    trackPath.addRect(rect);

    canvas.drawPath(trackPath, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(TrackPainter old) => this.color != old.color;
}

class ThumbPainter extends CustomPainter {
  final double value;
  final double max;
  final _SliderType type;
  final dynamic baseColor;
  final double growthFactor;
  final Color thumbColor;

  ThumbPainter(
    this.value,
    this.max,
    this.baseColor,
    this.type,
    this.growthFactor,
    this.thumbColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    dynamic color;
    final transformedValue = value * max;
    bool useValue = baseColor is HSVColor;

    switch (type) {
      case _SliderType.HUE:
        color = HSVColor.fromAHSV(1.0, transformedValue, 1.0, 1.0);
        break;
      case _SliderType.SATURATION:
        if (useValue) {
          color = HSVColor.fromAHSV(
            1.0,
            baseColor.hue,
            transformedValue,
            baseColor.value,
          );
        } else {
          color = HSLColor.fromAHSL(
            1.0,
            baseColor.hue,
            transformedValue,
            baseColor.lightness,
          );
        }
        break;
      case _SliderType.LIGHTNESS:
        color = HSLColor.fromAHSL(
          1.0,
          baseColor.hue,
          baseColor.saturation,
          transformedValue,
        );
        break;
      case _SliderType.VALUE:
        color = HSVColor.fromAHSV(
          1.0,
          baseColor.hue,
          baseColor.saturation,
          transformedValue,
        );
        break;
      case _SliderType.RED:
        color = Color.fromRGBO(
          transformedValue.toInt(),
          0,
          0,
          1.0,
        );
        break;
      case _SliderType.GREEN:
        color = Color.fromRGBO(
          0,
          transformedValue.toInt(),
          0,
          1.0,
        );
        break;
      case _SliderType.BLUE:
        color = Color.fromRGBO(
          0,
          0,
          transformedValue.toInt(),
          1.0,
        );
        break;
    }

    final offset = Offset(
      (size.width - _kThumbRadius * 2) * value + _kThumbRadius,
      (_kThumbRadius / 2) + size.height / 2 - _kThumbRadius / 2,
    );

    final rect = Rect.fromCircle(
      center: offset,
      radius: _kThumbRadius + (4 * growthFactor),
    );
    final path = Path()..addOval(rect);

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withOpacity(1)
        ..maskFilter = MaskFilter.blur(BlurStyle.outer, 1.6),
    );

    canvas.drawPath(path, Paint()..color = Colors.white);
    canvas.drawPath(
      Path()
        ..addOval(
          Rect.fromCircle(
            center: offset,
            radius: growthFactor * _kTrackHeight,
          ),
        ),
      Paint()..color = color is Color ? color : color.toColor(),
    );
  }

  @override
  bool shouldRepaint(ThumbPainter old) {
    return this.value != old.value ||
        this.max != old.max ||
        this.baseColor != old.baseColor ||
        this.growthFactor != old.growthFactor ||
        this.thumbColor != old.thumbColor;
  }
}

enum _SliderType {
  HUE,
  SATURATION,
  LIGHTNESS,
  VALUE,
  RED,
  GREEN,
  BLUE,
}

enum PickerMode {
  RGB,
  HSL,
  HSV,
}
