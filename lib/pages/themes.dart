import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/themes.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class Themes extends StatelessWidget {
  final ThemesDataProvider provider = ThemesDataProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: _ThemesBody(),
    );
  }
}

class _ThemesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _header(context),
        PageParser(
          dataKey: 'themes',
          useTopPadding: false,
        ),
      ],
    );
  }

  Widget _header(context) => Padding(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                                    ? Colors.black
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
                _pref(context, Icons.wifi, Colors.blue),
                _pref(context, Icons.devices_other, Colors.green),
                _pref(context, Icons.apps, Colors.orange),
              ],
            ),
          ),
        ),
      );

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
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.2),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).textTheme.body1.color.withOpacity(0.15),
          ),
        ),
      ),
    );
  }
}
