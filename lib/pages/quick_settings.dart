import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class QuickSettings extends StatelessWidget {
  final title = 'Quick Settings';
  final icon = Icons.swap_vertical_circle;
  final ThemeBloc bloc;
  QuickSettings({this.bloc});

  @override
  Widget build(BuildContext context) {
    return FriesPage(
      title: title,
      header: _header(context),
      children: <Widget>[

      ],
    );
  }

  Widget _header(context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 3.4,
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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
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
                            top: 4.0, bottom: 4.0, right: 0.0),
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
          ],
        ),
      ),
    ),
  );
}
