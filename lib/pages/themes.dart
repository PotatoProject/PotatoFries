import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:provider/provider.dart';

class Themes extends BasePage {
  @override
  String get title => LocaleStrings.themes.title;

  @override
  IconData get icon => Icons.color_lens;

  @override
  String get providerKey => 'themes';

  @override
  Widget buildHeader(context) {
    final provider = context.watch<PageProvider>();
    final appInfo = context.watch<AppInfoProvider>();

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: SizedBox(
        height: (MediaQuery.of(context).size.width / 16) * 9,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          elevation: 0,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 6),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 56,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Image.memory(
                              provider.getIconPackPreview(
                                  appInfo.iconPreviews)["ic_search_24dp"],
                              color: Theme.of(context).accentColor,
                              colorBlendMode: BlendMode.srcIn,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          Opacity(
                            opacity: 0.65,
                            child: Text(
                              LocaleStrings.themes.headerSearchSettings,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              bottom: 4,
                              right: 16,
                            ),
                            child: Image.memory(
                              provider.getIconPackPreview(appInfo.iconPreviews)[
                                  "ic_settings_multiuser"],
                              color: Theme.of(context).accentColor,
                              colorBlendMode: BlendMode.srcIn,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
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
    final provider = context.watch<PageProvider>();
    final appInfo = context.watch<AppInfoProvider>();

    return ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: ShapedIcon.currentShape(
          iconSize: 40,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 24,
              width: 24,
              color: Colors.transparent,
              child: Image.memory(
                provider.getIconPackPreview(appInfo.iconPreviews)[icon],
                color: Theme.of(context).scaffoldBackgroundColor,
                colorBlendMode: BlendMode.srcIn,
                width: 24,
                height: 24,
              ),
            ),
          ),
          color: color,
        ),
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
