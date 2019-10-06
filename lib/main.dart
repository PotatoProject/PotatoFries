import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/internal/common.dart';
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
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  int currentPage = 0;
  double titleBarHeight = 70;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark
      )
    );
    
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: Container(
                height: MediaQuery.of(context).padding.top + titleBarHeight,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  height: titleBarHeight,
                  child: Row(
                    children: <Widget>[
                      Text(
                        FriesPage.pages[currentPage].title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + titleBarHeight),
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + titleBarHeight) - 64,
              child: PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(index.toString()),
                  );
                },
                itemCount: FriesPage.pages.length,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
              ),
            ),
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
              onItemClick: (index) {
                setState(() => currentPage = index);
                pageController.jumpToPage(index);
              },
            ),
          ],
        ),
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
