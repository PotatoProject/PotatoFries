import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/cupertino.dart';

class CustomWidgetRegistry {
  static Set<CustomWidget> _registry = <CustomWidget>{};

  static Set<CustomWidget> get registry => Set.from(_registry);

  static void register(CustomWidget c) => _registry.add(c);

  static Widget fromString(String type) => _registry
      .firstWhere(
        (element) => element.type == type,
        orElse: () => CustomWidget(
          Container(),
          {},
        ),
      )
      .widget;
}

class CustomWidget {
  final Widget widget;
  final Map<SettingKey, dynamic> settings;
  final String type;

  CustomWidget(this.widget, this.settings)
      : this.type = widget.runtimeType.toString();
}
