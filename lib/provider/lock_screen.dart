import 'dart:convert';

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/page_provider.dart';

class LockScreenProvider extends PageProvider {
  static const String lockScreenProviderKey = 'lock_screen';

  LockScreenProvider({String providerKey = lockScreenProviderKey})
      : assert(providerKey == lockScreenProviderKey),
        super(lockScreenProviderKey) {
    loadLSClockData();
  }

  static const String LS_CLOCK = "lock_screen_custom_clock_face";

  void loadLSClockData() async {
    String valueStr =
        await AndroidFlutterSettings.getString(LS_CLOCK, SettingType.SECURE);
    Map value = valueStr == null ? null : json.decode(valueStr);
    this.setValue(LS_CLOCK, getLSClockKey(value['clock']), mapSet: true);
  }

  String getLSClockData() => this.getValue(LS_CLOCK);

  void setLSClockData(String data) async {
    Map<String, String> value = {
      'clock': lockClocks[data] ?? lockClocks[lockClocks.keys.toList()[0]],
    };
    await AndroidFlutterSettings.putString(
      LS_CLOCK,
      json.encode(value),
      SettingType.SECURE,
    );
    return this.setValue(LS_CLOCK, getLSClockKey(value['clock']), mapSet: true);
  }

  String getLSClockValue(String key) =>
      lockClocks[key] ?? lockClocks[lockClocks.keys.toList()[0]];

  String getLSClockKey(String value) =>
      lockClocks.keys.firstWhere((key) => lockClocks[key] == value,
          orElse: () => lockClocks.keys.toList()[0]);
}
