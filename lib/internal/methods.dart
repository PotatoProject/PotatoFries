import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void launchUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url!';
}

void setColors(BuildContext context) async {
  dark = Color(
    int.parse(
      "ff" +
          await AndroidFlutterSettings.getProp(
              "persist.sys.theme.accent_dark"),
      radix: 16,
    ),
  );
  light = Color(
    int.parse(
      "ff" +
          await AndroidFlutterSettings.getProp(
              "persist.sys.theme.accent_light"),
      radix: 16,
    ),
  );

  bloc.changeAccent(
    Theme.of(context).brightness == Brightness.dark ? dark : light,
  );
}

void showColorPicker(
  BuildContext context, {
  bool lightnessLocked = false,
  double lightnessDeltaCenter = 0,
  double lightnessDeltaEnd = 0,
  Function onApply,
  Function onChange,
  Color defaultDark,
  Color defaultLight,
  Color defaultColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ColorPicker(
      lightnessLocked: lightnessLocked,
      lightnessDeltaCenter: lightnessDeltaCenter,
      lightnessDeltaEnd: lightnessDeltaEnd,
      onApply: onApply,
      onChange: onChange,
      defaultDark:defaultDark,
      defaultLight:defaultLight,
      defaultColor:defaultColor,
    ),
  );
}
