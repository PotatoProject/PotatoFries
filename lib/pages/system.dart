import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/page_provider_registry.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class System extends BasePage {
  @override
  String get title => LocaleStrings.system.title;

  @override
  IconData get icon => Icons.android;

  @override
  String get providerKey => 'system';

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
