import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider_registry.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class Themes extends BasePage {
  @override
  String get title => "Themes";

  @override
  IconData get icon => OMIcons.colorLens;

  @override
  String get providerKey => 'themes';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PageProviderRegistry.getProvider(providerKey),
      child: Builder(
        builder: (providerContext) => Column(
          children: <Widget>[
            _header(providerContext),
            PageParser(
              dataKey: providerKey,
              useTopPadding: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    final appInfo = Provider.of<AppInfoProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: SizedBox(
        height: (MediaQuery.of(context).size.width / 16) * 9,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          margin: EdgeInsets.all(0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 56,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    color: Theme.of(context).cardColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Image.memory(
                            appInfo.getIconPackPreview()["ic_search_24dp"],
                            color: Theme.of(context).accentColor,
                            colorBlendMode: BlendMode.srcIn,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Opacity(
                          opacity: 0.65,
                          child: Text('Search settings'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            right: 16,
                          ),
                          child: Image.memory(
                            appInfo
                                .getIconPackPreview()["ic_settings_multiuser"],
                            color: Theme.of(context).accentColor,
                            colorBlendMode: BlendMode.srcIn,
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _pref(context, "ic_settings_wireless", Colors.blue),
              _pref(context, "ic_devices_other", Colors.green),
              _pref(context, "ic_apps", Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pref(BuildContext context, String icon, Color color) {
    final appInfo = Provider.of<AppInfoProvider>(context);

    return ListTile(
      leading: ShapedIcon.currentShape(
        iconSize: 40,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Image.memory(
            appInfo.getIconPackPreview()[icon],
            color: Theme.of(context).scaffoldBackgroundColor,
            colorBlendMode: BlendMode.srcIn,
            width: 24,
            height: 24,
          ),
        ),
        color: color,
      ),
      title: Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).textTheme.headline6.color.withOpacity(0.2),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                Theme.of(context).textTheme.headline6.color.withOpacity(0.15),
          ),
        ),
      ),
    );
  }
}
