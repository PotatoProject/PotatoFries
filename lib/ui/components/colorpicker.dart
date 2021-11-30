import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/backend/extensions.dart';

class ColorDisplay extends StatelessWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onColorChanged;
  final FocusNode focusNode;
  final TextEditingController controller;

  const ColorDisplay({
    required this.color,
    this.onColorChanged,
    required this.focusNode,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness colorBrightness =
        ThemeData.estimateBrightnessForColor(color.toColor());
    final Color foregroundColor =
        colorBrightness == Brightness.light ? Colors.black : Colors.white;

    return Material(
      color: color.toColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: context.theme.colorScheme.outline),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                context.focusScope.requestFocus(focusNode);
              },
            ),
          ),
          Center(
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
              style: context.friesTheme.textTheme.titleMedium!.copyWith(
                color: foregroundColor,
              ),
              cursorColor: foregroundColor,
              focusNode: focusNode,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                if (text.length == 6) {
                  onColorChanged?.call(HSLColor.fromColor(
                    Color(int.parse("FF$text", radix: 16)),
                  ));
                } else {
                  onColorChanged?.call(color);
                }
              },
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp("[0-9|A-F|a-f]"),
                ),
                LengthLimitingTextInputFormatter(6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onValueChanged;

  const ColorPicker({
    required this.color,
    this.onValueChanged,
    Key? key,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double get hue => widget.color.hue;
  double get hueFraction => widget.color.hue / 360;
  double get saturation => widget.color.saturation;
  double get lightness => widget.color.lightness;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _HueSaturationSquare(
            color: widget.color,
            onValueChanged: widget.onValueChanged,
          ),
        ),
        const SizedBox(width: 16),
        _LightnessSlider(
          color: widget.color,
          onValueChanged: widget.onValueChanged,
        )
      ],
    );
  }
}

class _HueSaturationSquare extends StatelessWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onValueChanged;

  const _HueSaturationSquare({
    required this.color,
    required this.onValueChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        return GestureDetector(
          onHorizontalDragUpdate: (details) => _updateHueSat(
            details.localPosition,
            constraints.biggest,
          ),
          onTapDown: (details) => _updateHueSat(
            details.localPosition,
            constraints.biggest,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
                        const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const HSVColor.fromAHSV(1.0, 0.0, 0.0, 0.5).toColor(),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned.fromRect(
                rect: Rect.fromCircle(
                  center: Offset(
                    color.hue / 360 * width,
                    (1 - color.saturation) * height,
                  ),
                  radius: 16,
                ),
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Material(
                      color: HSVColor.fromAHSV(
                        1.0,
                        color.hue,
                        color.saturation,
                        1.0,
                      ).toColor(),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateHueSat(Offset position, Size size) {
    onValueChanged?.call(HSLColor.fromAHSL(
      1,
      (position.dx / size.width * 360).clamp(0.0, 360.0),
      1 - (position.dy / size.height).clamp(0.0, 1.0),
      color.lightness,
    ));
  }
}

class _LightnessSlider extends StatelessWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onValueChanged;

  const _LightnessSlider({
    required this.color,
    required this.onValueChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragUpdate: (details) => _updateLightness(
          details.localPosition.dy,
          constraints.maxHeight,
        ),
        onTapDown: (details) => _updateLightness(
          details.localPosition.dy,
          constraints.maxHeight,
        ),
        child: Container(
          width: 32,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                HSLColor.fromAHSL(1.0, color.hue, 1.0, 0.5).toColor(),
                Colors.black,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fromRect(
                rect: Rect.fromCenter(
                  center: Offset(
                    16,
                    (1 - color.lightness) * constraints.maxHeight,
                  ),
                  width: 56,
                  height: 16,
                ),
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: StadiumBorder(),
                    shadows: [
                      BoxShadow(blurRadius: 1.6),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Material(
                      color: HSLColor.fromAHSL(
                        1.0,
                        color.hue,
                        1.0,
                        color.lightness,
                      ).toColor(),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _updateLightness(double y, double height) {
    onValueChanged?.call(color.withLightness((1 - y / height).clamp(0.0, 1.0)));
  }
}
