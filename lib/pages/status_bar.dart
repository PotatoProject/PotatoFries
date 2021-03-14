import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/widgets/video_widget.dart';
import 'package:provider/provider.dart';

class StatusBar extends BasePage {
  @override
  String get title => LocaleStrings.statusbar.title;

  @override
  IconData get icon => Icons.wifi;

  @override
  String get providerKey => "status_bar";

  @override
  Widget buildHeader(context) {
    var _appInfo = context.watch<AppInfoProvider>();
    var _provider = context.watch<PageProvider>();

    final hasCutout = !_appInfo.isCompatCheckDisabled()
        ? _provider.getValue(PropKey('ro.potato.has_cutout')) == "true"
        : true;

    if (hasCutout) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: VideoWidget(asset: 'assets/cutout_modes.mp4'),
      );
    } else {
      return null;
    }
  }
}
