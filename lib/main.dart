import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/components/app.dart';
import 'package:potato_fries/ui/components/preferences.dart';
import 'package:potato_fries/ui/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MonetProvider monet = await MonetProvider.newInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: monet),
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
        children: [
          SwitchPreferenceTile(
            icon: const Icon(Icons.invert_colors),
            title: "Verify apps over USB",
            subtitle: "Check apps installed via ADB/ADT for harmful behaviour",
            value: toggled,
            onValueChanged: (value) => setState(() => toggled = value),
          ),
          SliderPreferenceTile<double>(
            icon: const Icon(Icons.power_settings_new),
            title: "Enable GPU debug layers",
            value: sliderValue,
            min: 0,
            max: 1,
            onValueChanged: (value) => setState(() => sliderValue = value),
            enabled: toggled,
          ),
          DropdownPreferenceTile<int>(
            title: "Logger buffer sizes",
            options: _options,
            selectedOption: selectedOption,
            onValueChanged: (value) => setState(() => selectedOption = value),
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
