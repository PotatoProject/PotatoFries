import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

part 'monet.dart';

const MethodChannel _utilsChannel = MethodChannel("fries/utils");

class AppInfo extends ChangeNotifier {
  AppInfo._();

  static AppInfo of(BuildContext context, {bool listen = true}) {
    return Provider.of<AppInfo>(context, listen: listen);
  }

  Uint8List? _wallpaper;
  late MonetColors _colors;

  Uint8List? get wallpaper => _wallpaper;
  MonetColors get colors => _colors;

  static Future<AppInfo> newInstance() async {
    final AppInfo appInfo = AppInfo._();
    await appInfo._loadData();
    return appInfo;
  }

  Future<void> _loadData() async {
    await _updateColors();
    await _updateWall();

    _utilsChannel.setMethodCallHandler((call) async {
      if (call.method == "onColorsChanged") {
        final String reason = call.arguments as String;

        switch (reason) {
          case "wallpaper":
            await _updateWall();
            continue config;
          config:
          case "config":
            await _updateColors();
            notifyListeners();
        }
      }
    });
  }

  Future<void> _updateColors() async {
    _colors = await MonetUtils.getMonetColors();
  }

  Future<void> _updateWall() async {
    _wallpaper = await _utilsChannel.invokeMethod<Uint8List>("getWallpaper");
  }
}
