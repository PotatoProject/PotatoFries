import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/ui/croquette-badge.dart';

BorderRadius _kBorderRadius = BorderRadius.circular(12);

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Fries',
        theme: ThemeData.light().copyWith(accentColor: Colors.blue),
        darkTheme: ThemeData.dark().copyWith(accentColor: Colors.blue),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CroquetteBadge(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('v3.0.0-beta+1'),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bottomAppBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton,
      );
}

Widget get _floatingActionButton => Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: HSLColor.fromColor(Theme.of(context).accentColor)
            .withLightness(0.85)
            .toColor(),
        child: Icon(
          Icons.home,
          color: HSLColor.fromColor(Theme.of(context).accentColor)
              .withLightness(0.4)
              .toColor(),
        ),
      ),
    );

Widget get _bottomAppBar => ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: _kBorderRadius.topLeft,
        topRight: _kBorderRadius.topRight,
      ),
      child: Builder(
        builder: (context) {
          return BottomAppBar(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.system_update),
                    onPressed: () {},
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => launchUrl("https://potatoproject.co/team"),
                  ),
                  Spacer(flex: 4),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {},
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_up),
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
