import 'package:flutter/material.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/page_provider_registry.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:potato_fries/widgets/video_widget.dart';
import 'package:provider/provider.dart';

class StatusBar extends BasePage {
  @override
  String get title => "Statusbar";

  @override
  IconData get icon => CustomIcons.status_bar;

  @override
  String get providerKey => "status_bar";

  @override
  Widget build(BuildContext context) {
    var _provider = PageProviderRegistry.getProvider(providerKey);

    return ChangeNotifierProvider.value(
      value: PageProviderRegistry.getProvider(providerKey),
      child: Builder(
        builder: (providerContext) {
          bool hasCutout =
              _provider.getValue('SYSTEM:display_cutout_mode~COMPAT') ?? false;
          return Column(
            children: <Widget>[
              hasCutout ? _header(context) : Container(),
              PageParser(
                dataKey: providerKey,
                useTopPadding: !hasCutout,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _header(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: VideoWidget(asset: 'assets/cutout_modes.mp4'),
    );
  }
}

