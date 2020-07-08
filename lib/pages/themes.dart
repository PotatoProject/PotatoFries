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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      var temp = width;
      width = height;
      height = temp;
    }

    List<Widget> dummySettingPrefs = orientation == Orientation.portrait
        ? [
            _pref(context, Icons.wifi, Colors.blue),
            _pref(context, Icons.devices_other, Colors.green),
            _pref(context, Icons.apps, Colors.orange),
          ]
        : [
            _pref(context, Icons.wifi, Colors.blue),
          ];
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: SizedBox(
        height: orientation == Orientation.portrait
            ? (width / 16) * 9
            : height * 0.15,
        width: width,
        child: Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).backgroundColor
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
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Opacity(
                          opacity: 0.65,
                          child: Text('Search settings'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, right: 4.0),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).backgroundColor
                                  : Colors.white,
                            ),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ...dummySettingPrefs,
            ],
          ),
        ),
      ),
    );
  }

  Widget _pref(BuildContext context, IconData icon, Color color) {
    return ListTile(
      leading: ShapedIcon(
        type: Provider.of<AppInfoProvider>(context).getIconShapeIndex(),
        iconSize: 40,
        child: Icon(
          icon,
          color: Colors.white,
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
