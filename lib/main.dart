import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/bottom_sheet.dart';

BorderRadius _kBorderRadius = BorderRadius.circular(12);

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  final bloc = ThemeBloc();
  @override
  Widget build(context) => StreamBuilder<Color>(
    initialData: Colors.blue,
    stream: bloc.currentAccent,
    builder: (context, snapshot) {
      return MaterialApp(
            title: 'Fries',
            theme: ThemeData.light().copyWith(accentColor: snapshot.data),
            darkTheme: ThemeData.dark().copyWith(
                accentColor: snapshot.data,
                cardColor: Color(0xFF212121),
                scaffoldBackgroundColor: Color(0xFF151618)),
            home: MyHomePage(bloc: bloc),
            debugShowCheckedModeBanner: false,
          );
    }
  );
}

class MyHomePage extends StatefulWidget {
  final ThemeBloc bloc;
  MyHomePage({this.bloc});

  @override
  createState() => _MyHomePageState(bloc: bloc);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  int currentPage = 0;
  final ThemeBloc bloc;

  _MyHomePageState({this.bloc});

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    setPages(bloc);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: null,
      body: Stack(
        children: <Widget>[
          pages[currentPage],
          Positioned.fill(child: _sheetBackdrop),
          BottomAppSheet(
            controller: controller,
            currentPage: currentPage,
            onItemClick: (index) {
              setState(() => currentPage = index);
              controller.reverse();
            },
          ),
        ],
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
