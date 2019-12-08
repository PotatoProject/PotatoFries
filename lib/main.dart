import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/scroll_behavior.dart';

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  final bloc = ThemeBloc();

  @override
  Widget build(context) => StreamBuilder<Color>(
        initialData: Colors.blue,
        stream: bloc.currentAccent,
        builder: (context, snapshot) {
          return MaterialApp(
            builder: (context, child) => ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: child,
            ),
            title: 'Fries',
            theme: ThemeData.light().copyWith(accentColor: snapshot.data),
            darkTheme: ThemeData.dark().copyWith(
              accentColor: snapshot.data,
              cardColor: Color(0xFF212121),
              scaffoldBackgroundColor: Color(0xFF151618),
            ),
            home: MyHomePage(bloc: bloc),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  final ThemeBloc bloc;

  MyHomePage({this.bloc});

  @override
  createState() => _MyHomePageState(bloc: bloc);
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  final ThemeBloc bloc;

  _MyHomePageState({this.bloc});

  @override
  void initState() {
    super.initState();
    setPages(context, bloc);
    setColors();
  }

  void setColors() async {
    Color dark = Color(
      int.parse(
        "ff" +
            await AndroidFlutterSettings.getProp(
                "persist.sys.theme.accent_dark"),
        radix: 16,
      ),
    );
    Color light = Color(
      int.parse(
        "ff" +
            await AndroidFlutterSettings.getProp(
                "persist.sys.theme.accent_light"),
        radix: 16,
      ),
    );

    bloc.changeAccent(
      Theme.of(context).brightness == Brightness.dark ? dark : light,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: null,
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: navbarItemBuilder,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) => setState(() => currentPage = index),
        showSelectedLabels: true,
        selectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }

  List<BottomNavigationBarItem> get navbarItemBuilder {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < pages.length; i++) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon((pages[i] as dynamic).icon),
          title: Text((pages[i] as dynamic).title),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      );
    }
    return items;
  }
}
