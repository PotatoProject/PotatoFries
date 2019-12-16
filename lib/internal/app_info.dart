import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoProvider extends ChangeNotifier {
  PrefManager manager;
  AppInfoProvider() {
    loadData();
  }

  List<String> _savedColors = [];

  List<String> get savedColors => _savedColors;

  set savedColors(List<String> colors) {
    _savedColors = colors;
    manager.setSavedColors(colors);
    notifyListeners();
  }

  Future<void> loadData() async {
    manager = PrefManager(await SharedPreferences.getInstance());

    _savedColors = manager.getSavedColors();
  }
}

class PrefManager {
  SharedPreferences preferences;

  PrefManager(this.preferences);

  void setSavedColors(List<String> colors) async =>
      await preferences.setStringList("saved_colors", colors ?? []);

  List<String> getSavedColors() =>
      preferences.getStringList("saved_colors") ?? [];
}
