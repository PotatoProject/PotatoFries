import 'package:flutter/material.dart';
import 'package:potato_fries/app_native/resources.dart';

class AppInfoProvider extends ChangeNotifier {
  AppInfoProvider() {
    loadData();
  }

  int _pageIndex = 0;
  Color _accentDark = Colors.lightBlueAccent;
  Color _accentLight = Colors.blueAccent;

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  set accentDark(Color val) {
    _accentDark = val;
    notifyListeners();
  }

  set accentLight(Color val) {
    _accentLight = val;
    notifyListeners();
  }

  Color get accentDark => _accentDark;

  Color get accentLight => _accentLight;

  int get pageIndex => _pageIndex;

  void loadData() async {
    _accentDark = Color(await Resources.getAccentDark());
    _accentLight = Color(await Resources.getAccentLight());
    notifyListeners();
  }
}
