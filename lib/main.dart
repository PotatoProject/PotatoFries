import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/ui/bottom_sheet.dart';
import 'package:potato_fries/ui/croquette-badge.dart';

BorderRadius _kBorderRadius = BorderRadius.circular(12);

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fries',
      theme: ThemeData.light().copyWith(accentColor: Colors.blue),
      darkTheme: ThemeData.dark().copyWith(accentColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  CurrentMenuPages currentPage = CurrentMenuPages.QS;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: <Widget>[
          Container(),
          AnimatedBuilder(
            animation: Tween<double>(begin: 0, end: 1).animate(controller),
            builder: (context, child) {
              return Visibility(
                visible: controller.value != 0,
                child: Opacity(
                  opacity: controller.value,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      controller.reverse();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0x66000000),
                    ),
                  ),
                ),
              );
            },
          ),
          BottomAppSheet(
            controller: controller,
            currentPage: currentPage,
            onItemClick: (index) {},
          ),
        ],
      ),
      /*body: Center(
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
      ),*/
      //bottomNavigationBar: _bottomAppBar,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: _floatingActionButton,
    );
  }
}

Widget get _floatingActionButton {
  return Builder(
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
}

Widget get _bottomAppBar {
  return ClipRRect(
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
                Spacer(),
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
}
