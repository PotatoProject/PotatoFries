import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/widgets/disco_spinner.dart';
import 'package:potato_fries/widgets/multi_mode_color_picker.dart';
import 'package:provider/provider.dart';

class SettingsColorTile extends StatefulWidget {
  final SettingPreference pref;
  final bool enabled;

  SettingsColorTile({
    @required this.pref,
    this.enabled = true,
  }) : assert(pref != null);

  @override
  _SettingsColorTileState createState() => _SettingsColorTileState();
}

class _SettingsColorTileState extends State<SettingsColorTile> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<PageProvider>();
    final pref = widget.pref;
    final options = widget.pref.options as ColorOptions;

    return ColorTile(
      title: pref.title,
      description: pref.description,
      pref: pref,
      options: options,
      onApply: (Color color) {
        _provider.setValue(pref.setting, color.value.toSigned(32));
        Navigator.of(context).pop();
      },
    );
  }
}

class ColorTile extends StatelessWidget {
  final String title;
  final String description;
  final SettingPreference pref;
  final ColorOptions options;
  final void Function(Color color) onApply;

  ColorTile({
    this.title,
    this.description,
    this.onApply,
    this.pref,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PageProvider>();
    int colorValue = provider.getValue(pref.setting);
    final color = colorValue == null ? null : Color(colorValue).withOpacity(1);

    return SizeableListTile(
      title: title,
      subtitle: Text(description),
      icon: ShapedIcon.currentShape(
        iconSize: 24,
        child: Row(
          children: <Widget>[
            color == null
                ? DiscoSpinner(isSpinning: false, size: 24)
                : Container(
                    height: 24,
                    width: 24,
                    color: color,
                  ),
          ],
        ),
      ),
      onTap: () {
        Utils.showBottomSheet(
          context: context,
          builder: (context) => _TileContent(
            color: color,
            onApply: onApply,
            options: options,
          ),
        );
      },
    );
  }
}

class _TileContent extends StatefulWidget {
  final Color color;
  final double tolerance;
  final ColorOptions options;
  final void Function(Color color) onApply;

  _TileContent({
    this.color,
    this.onApply,
    this.tolerance = 0.5,
    this.options,
  }) : assert(tolerance >= 0.0 && tolerance <= 1.0);

  @override
  __TileContentState createState() => __TileContentState();
}

class __TileContentState extends State<_TileContent> {
  bool isColorTooDark = false;
  bool isColorTooLight = false;

  PickerMode mode = PickerMode.RGB;
  Color _color;

  @override
  void initState() {
    _color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: MultiModeColorPicker(
                      options: widget.options,
                      color: widget.color ?? Colors.black,
                      mode: mode,
                      onColorChanged: (color) {
                        final hsl = HSLColor.fromColor(color);
                        setState(
                          () {
                            isColorTooLight =
                                hsl.lightness >= widget.options.maxLightness;
                            isColorTooDark =
                                hsl.lightness <= widget.options.minLightness;
                            _color = color;
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getErrorLabelWidget(lightLabel),
              getErrorLabelWidget(darkLabel),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToggleButtons(
                      children: [
                        Text('RGB'),
                        Text('HSL'),
                        Text('HSV'),
                      ],
                      fillColor: Theme.of(context).accentColor,
                      selectedColor: Theme.of(context).cardColor,
                      isSelected: [
                        mode == PickerMode.RGB,
                        mode == PickerMode.HSL,
                        mode == PickerMode.HSV,
                      ],
                      borderRadius: BorderRadius.circular(6),
                      onPressed: (index) {
                        mode = PickerMode.values[index];
                        setState(() {});
                      },
                    ),
                    Spacer(),
                    TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          LocaleStrings.themes.themesSystemAccentCancel
                              .toUpperCase(),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 4),
                    TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          LocaleStrings.themes.themesSystemAccentConfirm
                              .toUpperCase(),
                        ),
                      ),
                      onPressed: !(isColorTooLight || isColorTooDark) ||
                              widget.options.supportsNormalization
                          ? () => widget.onApply?.call(_color)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String get lightLabel {
    if (isColorTooLight) {
      return widget.options.supportsNormalization
          ? LocaleStrings.preferences.colorpickerLightWarning
          : LocaleStrings.preferences.colorpickerLightError;
    }
    return "";
  }

  String get darkLabel {
    if (isColorTooDark) {
      return widget.options.supportsNormalization
          ? LocaleStrings.preferences.colorpickerDarkWarning
          : LocaleStrings.preferences.colorpickerDarkError;
    }
    return "";
  }

  Widget getErrorLabelWidget(String label) {
    if (label.trim().isEmpty) {
      return Container(
        height: 24,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Row(
        children: [
          Icon(
            widget.options.supportsNormalization
                ? Icons.warning_amber_outlined
                : Icons.error_outline,
            size: 16,
            color: widget.options.supportsNormalization
                ? Colors.amber
                : Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: widget.options.supportsNormalization
                  ? Colors.amber
                  : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
