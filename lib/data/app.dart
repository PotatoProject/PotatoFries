import 'package:potato_fries/data/buttons.dart';
import 'package:potato_fries/data/lock_screen.dart';
import 'package:potato_fries/data/misc.dart';
import 'package:potato_fries/data/qs.dart';
import 'package:potato_fries/data/status_bar.dart';
import 'package:potato_fries/data/themes.dart';

final Map<String, dynamic> appData = {
  'qs': qsData,
  'buttons_and_gestures': buttons,
  'themes': themeData,
  'status_bar': statusBar,
  'lock_screen': lockScreen,
  'misc': misc,
};
