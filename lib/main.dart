import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/scroll_behavior.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FriesRoot());
}

class FriesRoot extends StatelessWidget {
  final AppInfoProvider provider = AppInfoProvider();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Builder(builder: (context) {
        var appInfoProvider = Provider.of<AppInfoProvider>(context);
        return MaterialApp(
          builder: (context, child) => ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: child,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Fries',
          theme: ThemeData.light().copyWith(
            accentColor: appInfoProvider.accentDark,
            appBarTheme: AppBarTheme(
              actionsIconTheme: Theme.of(context).iconTheme,
              iconTheme: Theme.of(context).iconTheme,
              textTheme: Theme.of(context).textTheme,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            accentColor: appInfoProvider.accentLight,
            cardColor: Color(0xFF212121),
            scaffoldBackgroundColor: Color(0xFF151618),
          ),
          home: FriesHome(),
        );
      }),
    );
  }
}
