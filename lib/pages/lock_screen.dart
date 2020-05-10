import 'package:flutter/material.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/page_provider_registry.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class LockScreen extends BasePage {
  @override
  String get title => "Lock screen";

  @override
  IconData get icon => CustomIcons.screen_lock_portrait;

  @override
  String get providerKey => "lock_screen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PageProviderRegistry.getProvider(providerKey),
      child: Builder(
        builder: (providerContext) => Column(
          children: <Widget>[
            Container(),
            PageParser(dataKey: providerKey),
          ],
        ),
      ),
    );
  }
}
