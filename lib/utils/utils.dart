import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const MethodChannel _channel = const MethodChannel('fries/utils');

  static Future<void> startActivity({String pkg, String cls}) async =>
      await _channel.invokeMethod('startActivity', {'pkg': pkg, 'cls': cls});

  static Future<T> showBottomSheet<T>({
    BuildContext context,
    WidgetBuilder builder,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8,
            ),
            builder(context),
          ],
        );
      },
      isScrollControlled: true,
    );
  }

  static void showNavigationSheet({
    BuildContext context,
    List<BasePage> pages,
    Function(int index) onTap,
  }) {
    final provider = context.read<AppInfoProvider>();

    Utils.showBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          pages.length,
          (index) => ListTile(
            leading: Icon(
              pages[index].icon,
              color: provider.pageIndex == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              pages[index].title,
              style: TextStyle(
                color: provider.pageIndex == index
                    ? Theme.of(context).accentColor
                    : Theme.of(context).iconTheme.color,
              ),
            ),
            onTap: () {
              onTap(index);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static void launchUrl(String url, {BuildContext context}) async {
    if (await canLaunch(url))
      await launch(url);
    else {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to open $url!'),
          ),
        );
      }
    }
  }

  static SettingKey stringToSettingKey(String string) {
    try {
      final stringList = string.split(":");
      final name = stringList[2];
      final type = stringToSettingType(stringList[0]);
      final valueType = stringList[1];

      switch (valueType.toUpperCase()) {
        case 'BOOLEAN':
          return SettingKey<bool>(name, type);
        case 'INT':
          return SettingKey<int>(name, type);
        case 'STRING':
        default:
          return SettingKey<String>(name, type);
      }
    } on RangeError {
      throw ArgumentError.value(string);
    }
  }

  static SettingType stringToSettingType(String string) {
    switch (string.toUpperCase()) {
      case 'SYSTEM':
        return SettingType.SYSTEM;
      case 'SECURE':
        return SettingType.SECURE;
      case 'GLOBAL':
      default:
        return SettingType.GLOBAL;
    }
  }
}

extension SettingKeyStringDumper on SettingKey {
  String toJsonString() {
    return "${type.toValueString()}:${valueType.toValueString()}:$name";
  }
}

extension SettingTypeToValue on SettingType {
  String toValueString() {
    return this.toString().split(".").last.toUpperCase();
  }
}

extension SettingValueTypeToValue on SettingValueType {
  String toValueString() {
    return this.toString().split(".").last.toUpperCase();
  }
}
