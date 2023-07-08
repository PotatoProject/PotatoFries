import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/backend/appinfo.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/pages/licenses.dart';
import 'package:potato_fries/pages/search.dart';
import 'package:potato_fries/ui/themes/data.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppInfo appInfo = await AppInfo.newInstance();
  final SettingSink sink = SettingSink.newInstance();
  final PropertyRegister register = PropertyRegister();
  await Pages.registerAndSubscribe(sink, register);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appInfo),
        Provider.value(value: sink),
        Provider.value(value: register),
      ],
      child: const FriesRoot(),
    ),
  );
}

class FriesRoot extends StatelessWidget {
  const FriesRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final AppInfo appInfo = AppInfo.of(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MaterialApp(
      theme: FriesTheme.light(colors: appInfo.colors),
      darkTheme: FriesTheme.dark(colors: appInfo.colors),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/licenses': (context) => const LicensesPage(),
      },
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(
          context.theme.appBarTheme.systemOverlayStyle!,
        );

        return child!;
      },
    );
  }
}
