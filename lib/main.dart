import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/app_info.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/ui/scroll_behavior.dart';
import 'package:potato_fries/widgets/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'internal/methods.dart';

void main() => runApp(PotatoFriesRoot());

class PotatoFriesRoot extends StatelessWidget {
  final bloc = ThemeBloc();

  @override
  Widget build(context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<AppInfoProvider>.value(
            value: AppInfoProvider(),
          ),
        ],
        child: StreamBuilder<Color>(
          initialData: Colors.blue,
          stream: bloc.currentAccent,
          builder: (context, snapshot) {
            return MaterialApp(
              builder: (context, child) => ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: child,
              ),
              title: 'Fries',
              theme: ThemeData.light().copyWith(
                accentColor: snapshot.data,
                appBarTheme: AppBarTheme(
                    textTheme: Theme.of(context).textTheme,
                    actionsIconTheme: Theme.of(context).iconTheme,
                    iconTheme: Theme.of(context).iconTheme),
              ),
              darkTheme: ThemeData.dark().copyWith(
                accentColor: snapshot.data,
                cardColor: Color(0xFF212121),
                scaffoldBackgroundColor: Color(0xFF151618),
              ),
              home: MyHomePage(bloc: bloc),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final ThemeBloc bloc;

  MyHomePage({this.bloc});

  @override
  createState() => _MyHomePageState(bloc: bloc);
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int currentPage = 0;
  final ThemeBloc bloc;

  _MyHomePageState({this.bloc});

  @override
  void initState() {
    super.initState();
    setPages(context, bloc);
    setColors(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAppInfo(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: null,
      body: pages[currentPage],
      bottomNavigationBar: CustomBottomBar(
        currentIndex: currentPage,
        items: navbarItemBuilder,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) => setState(() => currentPage = index),
        selectedColor: Theme.of(context).accentColor,
      ),
    );
  }

  List<Widget> get navbarItemBuilder {
    List<Widget> items = [];
    for (int i = 0; i < pages.length; i++) {
      items.add(
        Icon(
          (pages[i] as dynamic).icon,
        ),
      );
    }
    return items;
  }
}
