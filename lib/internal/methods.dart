import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void launchUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url!';
}

void showColorPicker(
  BuildContext context, {
  bool lightnessLocked = false,
  double lightnessDeltaCenter = 0,
  double lightnessDeltaEnd = 0,
  Function onApply,
  Function onChange,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => ColorPicker(
      lightnessLocked: lightnessLocked,
      lightnessDeltaCenter: lightnessDeltaCenter,
      lightnessDeltaEnd: lightnessDeltaEnd,
      onApply: onApply,
      onChange: onChange,
    ),
  );
}
