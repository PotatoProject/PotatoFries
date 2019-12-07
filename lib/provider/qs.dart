import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:potato_fries/provider/base.dart';

class QSDataProvider extends BaseDataProvider {
  QSDataProvider() {
    loadData();
  }

  Map<String, dynamic> extraData = Map();

  void loadData() async {
    String colorSetting = 'qs_panel_bg_color';
    SettingType colorSettingType = SettingType.SYSTEM;
    extraData['${colorSettingType.toString()}/$colorSetting'] =
        await AndroidFlutterSettings.getInt(colorSetting, colorSettingType);
    notifyListeners();
  }
}
