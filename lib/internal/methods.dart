import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void launchUrl(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url!';
}

enum CurrentMenuPages {
  QS,
  STATUS_BAR,
  THEMES,
  BUTTONS_NAVIGATION,
}

class BottomSheetPageItem {
  Widget title;
  Widget icon;

  BottomSheetPageItem({
    this.title,
    this.icon
  });
}