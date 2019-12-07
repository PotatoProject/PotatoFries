import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseDataProvider extends ChangeNotifier {
  BaseDataProvider();

  Map<String, dynamic> _data = Map();

  Map<String, dynamic> get data => _data;

  set data(Map<String, dynamic> val) {
    _data = val;
    notifyListeners();
  }
}
