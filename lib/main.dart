import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/ui/bottom_sheet.dart';

BorderRadius _kBorderRadius = BorderRadius.circular(12);

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  @override
  Widget build(context) => MaterialApp(
        title: 'Fries',
        theme: ThemeData.light().copyWith(accentColor: Colors.blue),
        darkTheme: ThemeData.dark().copyWith(accentColor: Colors.blue),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  int currentPage = 0;
  double titleBarHeight = 70;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  FriesPage.pages[currentPage].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + titleBarHeight),
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + titleBarHeight) -
                  64,
              child: PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    Center(child: Text(index.toString())),
                itemCount: FriesPage.pages.length,
                onPageChanged: (index) => setState(() => currentPage = index),
              ),
            ),
            _sheetBackdrop,
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
    );
  }

  Widget get _sheetBackdrop => AnimatedBuilder(
        animation: Tween<double>(begin: 0, end: 1).animate(controller),
        builder: (context, child) => Visibility(
          visible: controller.value != 0,
          child: Opacity(
            opacity: controller.value,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) => controller.reverse(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Color(0x66000000),
              ),
            ),
          ),
        ),
      );
}
