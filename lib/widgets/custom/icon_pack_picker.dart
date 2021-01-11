import 'package:flutter/material.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:provider/provider.dart';

class IconPackPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appInfo = context.watch<AppInfoProvider>();
    final provider = context.watch<PageProvider>();
    final icons = appInfo.iconPreviews;
    final selectedPack = provider.globalTheme[OVERLAY_CATEGORY_ICON_ANDROID];

    return SizeableListTile(
      title: LocaleStrings.themes.themesSystemIconPackTitle,
      onTap: () {
        Utils.showBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 24,
                    bottom: 24,
                  ),
                  child: Text(
                    LocaleStrings.themes.themesSystemIconPackTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final MapEntry iconInfo = MapEntry(
                      icons.keys.toList()[index],
                      icons.values.toList()[index]["ic_wifi_signal_3"],
                    );
                    final selected = selectedPack == iconInfo.key;

                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          provider.setIconPack(iconInfo.key);
                        },
                        child: Image.memory(
                          iconInfo.value,
                          width: 36,
                          height: 36,
                          color: selected
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                  itemCount: icons.length,
                  shrinkWrap: true,
                ),
              ],
            );
          },
        );
      },
      icon: Image.memory(
        provider.getIconPackPreview(icons)["ic_wifi_signal_3"],
        width: 24,
        height: 24,
        color: Theme.of(context).iconTheme.color,
        colorBlendMode: BlendMode.srcIn,
      ),
      subtitle: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Text(provider.getIconPackLabel(appInfo.iconLabels)),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}
