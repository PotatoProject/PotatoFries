import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:provider/provider.dart';

class AppInfo extends ChangeNotifier {
  AppInfo._();

  static const MethodChannel _utilsChannel = MethodChannel("fries/utils");
  static AppInfo of(BuildContext context, {bool listen = true}) {
    return Provider.of<AppInfo>(context, listen: listen);
  }

  Uint8List? _wallpaper;
  late MonetColors _colors;
  late final MonetProvider monet;

  Uint8List? get wallpaper => _wallpaper;
  MonetColors get colors => _colors;

  static Future<AppInfo> newInstance() async {
    final AppInfo appInfo = AppInfo._();
    await appInfo._loadData();
    return appInfo;
  }

  Future<void> _loadData() async {
    monet = await MonetProvider.newInstance();
    await _updateWallAndColors();

    monet.addListener(() async {
      await _updateWallAndColors();
      notifyListeners();
    });
  }

  Future<void> _updateWallAndColors() async {
    _colors = monet.getColors(Colors.blue);
    _wallpaper = await _utilsChannel.invokeMethod<Uint8List>("getWallpaper");
  }
}
