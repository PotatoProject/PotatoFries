import 'dart:async';

import 'package:flutter/painting.dart';

class ThemeBloc {
  final _accentStreamController = StreamController<Color>();

  void changeAccent(Color value) => _accentStreamController.sink.add(value);

  get currentAccent => _accentStreamController.stream;

  void dispose() {
    _accentStreamController.close();
  }
}
