import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/widgets/animated_disable.dart';
import 'package:potato_fries/widgets/multi_mode_color_picker_dual.dart';
import 'package:provider/provider.dart';

class AccentPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiModeColorPickerTile(
        title: LocaleStrings.themes.themesSystemAccentTitle,
        subtitle: LocaleStrings.themes.themesSystemAccentDesc,
        onApply: (Color newLight, Color newDark) {
          final stringLight = newLight.value.toRadixString(16).substring(2, 8);
          final stringDark = newDark.value.toRadixString(16).substring(2, 8);

          context.read<PageProvider>().accentDarkString = stringDark;
          context.read<PageProvider>().accentLightString = stringLight;

          Navigator.pop(context);
        },
      );
}

class MultiModeColorPickerTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function(Color light, Color dark) onApply;

  MultiModeColorPickerTile({
    this.title,
    this.subtitle,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PageProvider>();
    final light = Color(provider.accentLight).withOpacity(1);
    final dark = Color(provider.accentDark).withOpacity(1);

    return SizeableListTile(
      title: title,
      subtitle: Text(subtitle),
      icon: ShapedIcon.currentShape(
        iconSize: 24,
        child: Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 12,
              color: light ?? Colors.black,
            ),
            Container(
              height: 24,
              width: 12,
              color: dark ?? Colors.white,
            ),
          ],
        ),
      ),
      onTap: () {
        Utils.showBottomSheet(
          context: context,
          builder: (context) => _TileContent(
            light: light,
            dark: dark,
            onApply: onApply,
          ),
        );
      },
    );
  }
}

class _TileContent extends StatefulWidget {
  final Color light;
  final Color dark;
  final double tolerance;
  final void Function(Color light, Color dark) onApply;

  _TileContent({
    this.light,
    this.dark,
    this.onApply,
    this.tolerance = 0.5,
  }) : assert(tolerance >= 0.0 && tolerance <= 1.0);

  @override
  __TileContentState createState() => __TileContentState();
}

class __TileContentState extends State<_TileContent> {
  bool isDarkColorTooDark = false;
  bool isDarkColorTooLight = false;
  bool isLightColorTooDark = false;
  bool isLightColorTooLight = false;

  PickerMode mode = PickerMode.RGB;
  Color _light;
  Color _dark;

  @override
  void initState() {
    _light = widget.light;
    _dark = widget.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = context.watch<AppInfoProvider>();
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
                    child: MultiModeColorPickerDual(
                      tolerance: widget.tolerance,
                      lightColor: widget.light,
                      darkColor: widget.dark,
                      mode: mode,
                      onColorChanged: (lightColor, darkColor) {
                        final hslLight = HSLColor.fromColor(lightColor);
                        final hslDark = HSLColor.fromColor(darkColor);

                        if (hslLight.lightness > 1.0 - widget.tolerance) {
                          setState(() => isLightColorTooLight = true);
                        } else {
                          setState(() => isLightColorTooLight = false);
                        }

                        if (hslDark.lightness < widget.tolerance) {
                          setState(() => isDarkColorTooDark = true);
                        } else {
                          setState(() => isDarkColorTooDark = false);
                        }

                        _light = lightColor;
                        _dark = darkColor;
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
                    AnimatedDisable(
                      disabled: appInfo.discoEasterActive,
                      child: ToggleButtons(
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
                      onPressed: !(isLightColorTooLight ||
                              isLightColorTooDark ||
                              isDarkColorTooLight ||
                              isDarkColorTooDark)
                          ? () {
                              widget.onApply?.call(_light, _dark);
                            }
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
    if (isLightColorTooDark) {
      return LocaleStrings.themes.themesSystemAccentLightColorDarkWarning;
    }

    if (isLightColorTooLight) {
      return LocaleStrings.themes.themesSystemAccentLightColorLightWarning;
    }

    return "";
  }

  String get darkLabel {
    if (isDarkColorTooDark) {
      return LocaleStrings.themes.themesSystemAccentDarkColorDarkWarning;
    }

    if (isDarkColorTooLight) {
      return LocaleStrings.themes.themesSystemAccentDarkColorLightWarning;
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
            Icons.error_outline,
            size: 16,
            color: Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
