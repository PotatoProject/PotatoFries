import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pagelayout/themes_page_layout.dart';
import 'package:potato_fries/pages/fries_page.dart';

class Themes extends StatelessWidget {
  final title = 'Themes';
  final icon = Icons.colorize;
  final ThemeBloc bloc;
  final int keyIndex;

  Themes({
    this.bloc,
    this.keyIndex,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> builtLayout = ThemesPageLayout().build(context, keyIndex);
    List<GlobalKey> keys = builtLayout["keys"];
    List<Widget> children = builtLayout["body"];

    Future.delayed(
      Duration.zero,
      () async {
        if (keyIndex != null) {
          Scrollable.ensureVisible(keys[keyIndex].currentContext);
        }
      },
    );

    if(keyIndex != null) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: FriesPage(
          title: title,
          header: _header(context),
          children: children,
          showActions: keyIndex == null,
        ),
      );
    } else {
      return FriesPage(
        title: title,
        header: _header(context),
        children: children
      );
    }
  }

  Widget _header(context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width - 24,
          child: Card(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 6),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 32),
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
                                color: HSLColor.fromColor(
                                                Theme.of(context).accentColor)
                                            .lightness >
                                        0.6
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
      leading: CircleAvatar(
        child: Icon(
          icon,
          color: Colors.white,
        ),
        backgroundColor: color,
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
