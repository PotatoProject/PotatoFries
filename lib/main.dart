import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/ui/components/app.dart';
import 'package:potato_fries/ui/components/preferences/settings.dart';
import 'package:potato_fries/ui/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MonetProvider monet = await MonetProvider.newInstance();

  final SettingSink sink = SettingSink.newInstance();
  await Settings.airplane_mode_on.subscribeTo(sink);
  await Settings.screen_brightness.subscribeTo(sink);
  await Settings.logger_buffer_size.subscribeTo(sink);
  /* for (final Setting setting in settings) {
    await setting.subscribeTo(sink);
  } */

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: monet),
        Provider.value(value: sink),
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
  static const Map<int, String> _options = {
    0: "Off",
    1: "64K",
    2: "256K",
    3: "1M",
    4: "4M",
    5: "8M",
  };
  int pageIndex = 0;
  double sliderValue = 0;
  bool toggled = true;
  int selectedOption = 0;

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
      body: Column(
        children: const [
          SwitchSettingPreference(
            setting: Settings.airplane_mode_on,
            icon: Icons.airplanemode_active,
            title: "Airplane mode",
          ),
          SliderSettingPreference<int>(
            setting: Settings.screen_brightness,
            icon: Icons.brightness_medium,
            title: "Brightness",
            min: 0,
            max: 255,
            dependencies: [
              SettingDependency(Settings.airplane_mode_on, true),
            ],
          ),
          DropdownSettingPreference<int>(
            setting: Settings.logger_buffer_size,
            title: "Logger buffer sizes",
            options: _options,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) => setState(() => pageIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.brightness_6_outlined),
            selectedIcon: Icon(Icons.brightness_6),
            label: "QS",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "System",
          ),
          NavigationDestination(
            icon: Icon(Icons.color_lens_outlined),
            selectedIcon: Icon(Icons.color_lens),
            label: "Themes",
          ),
          NavigationDestination(
            icon: Icon(Icons.signal_cellular_0_bar),
            selectedIcon: Icon(Icons.signal_cellular_4_bar),
            label: "Statusbar",
          ),
          NavigationDestination(
            icon: Icon(Icons.lock_outlined),
            selectedIcon: Icon(Icons.lock),
            label: "Keyguard",
          ),
        ],
      ),
    );
  }
}
