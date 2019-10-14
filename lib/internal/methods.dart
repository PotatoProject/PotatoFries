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
  Function onApply,
}) {
  showModalBottomSheet(context: context, builder: (context) => ColorPicker(
    lightnessLocked: lightnessLocked,
    onApply: onApply,
  ));
}
