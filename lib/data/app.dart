import 'package:potato_fries/data/system.dart';
import 'package:potato_fries/data/lock_screen.dart';
import 'package:potato_fries/data/qs.dart';
import 'package:potato_fries/data/status_bar.dart';
import 'package:potato_fries/data/themes.dart';

import 'models.dart';

final Map<String, Map<String, List<Preference>>> appData = {
  'qs': qsData,
  'system': system,
  'themes': themeData,
  'status_bar': statusBar,
  'lock_screen': lockScreen,
};
