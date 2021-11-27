import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/ui/components/app.dart';
import 'package:potato_fries/ui/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MonetProvider monet = await MonetProvider.newInstance();

  final SettingSink sink = SettingSink.newInstance();
  await Settings.airplane_mode_on.subscribeTo(sink);
  await Settings.screen_brightness.subscribeTo(sink);
  await Settings.logger_buffer_size.subscribeTo(sink);

  final PropertyRegister register = PropertyRegister();
  await Properties.ro_potato_has_cutout.registerTo(register);

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
  late final MonetProvider _monetProvider =
      Provider.of<MonetProvider>(context, listen: false);
  late MonetColors _colors;

  @override
  void initState() {
    super.initState();
    _colors = _monetProvider.getColors(Colors.blue);
    _monetProvider.addListener(() {
      _colors = _monetProvider.getColors(Colors.blue);
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
      home: const FriesHome(),
    );
  }
}

class FriesHome extends StatefulWidget {
  const FriesHome({Key? key}) : super(key: key);

  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<FriesHome> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fries"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Pages.list[pageIndex].build(context),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) => setState(() => pageIndex = index),
        destinations: Pages.list.map((e) => e.destination).toList(),
      ),
    );
  }
}
