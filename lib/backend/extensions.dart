import 'package:flutter/material.dart';
import 'package:potato_fries/backend/appinfo.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  SettingSink get sink => SettingSink.of(this);
  PropertyRegister get register => PropertyRegister.of(this);
  AppInfo get appInfo => AppInfo.of(this, listen: false);
  FocusScopeNode get focusScope => FocusScope.of(this);

  Future<T?> showBottomSheet<T>({
    required WidgetBuilder builder,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: 8,
          bottom: context.mediaQuery.viewPadding.bottom,
        ),
        child: Builder(builder: builder),
      ),
      isScrollControlled: true,
      enableDrag: enableDrag,
    );
  }
}

extension BrightnessX on Brightness {
  Brightness get inverted {
    switch (this) {
      case Brightness.dark:
        return Brightness.light;
      case Brightness.light:
        return Brightness.dark;
    }
  }
}

extension SettingSubscriber<T> on Setting<T> {
  Future<SettingSubscription<T>> subscribeTo(SettingSink sink) {
    return sink.subscribe<T>(this);
  }
}

extension PropertyRegisterer<T> on PropertyKey {
  Future<void> registerTo(PropertyRegister register) {
    return register.register(this);
  }
}
