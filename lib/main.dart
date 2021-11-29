import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/pages/search.dart';
import 'package:potato_fries/ui/components/app.dart';
import 'package:potato_fries/ui/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MonetProvider monet = await MonetProvider.newInstance();
  final SettingSink sink = SettingSink.newInstance();
  final PropertyRegister register = PropertyRegister();
  await Pages.registerAndSubscribe(sink, register);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: monet),
        Provider.value(value: sink),
        Provider.value(value: register),
      ],
      child: const FriesRoot(),
    ),
  );
}

class FriesRoot extends StatefulWidget {
  const FriesRoot({Key? key}) : super(key: key);

  @override
  _FriesRootState createState() => _FriesRootState();
}

class _FriesRootState extends State<FriesRoot> {
  late MonetColors _colors = context.monet.getColors(Colors.blue);

  @override
  void initState() {
    super.initState();
    context.monet.addListener(() {
      _colors = context.monet.getColors(Colors.blue);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return FriesApp(
      scrollBehavior: const MaterialScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      theme: FriesThemeData.light(colors: _colors),
      darkTheme: FriesThemeData.dark(colors: _colors),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
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
