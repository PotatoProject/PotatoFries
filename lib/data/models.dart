import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/smart_icon.dart';

@immutable
class Preference {
  final String minVersion;
  final List<Dependency> dependencies;

  Preference._(
    this.minVersion,
    this.dependencies,
  );
}

@immutable
class SettingPreference extends Preference {
  final String title;
  final String description;
  final SettingKey setting;
  final SmartIconData icon;
  final Options options;

  SettingPreference.withSwitch({
    @required this.title,
    this.description,
    @required String setting,
    SettingType type = SettingType.SYSTEM,
    this.icon,
    @required SwitchOptions options,
    String minVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.setting = SettingKey<bool>(setting, type),
        super._(minVersion, dependencies);

  SettingPreference.withSlider({
    @required this.title,
    @required String setting,
    SettingType type = SettingType.SYSTEM,
    @required SliderOptions options,
    String minVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.description = null,
        this.icon = null,
        this.setting = SettingKey<int>(setting, type),
        super._(minVersion, dependencies);

  SettingPreference.withDropdown({
    @required this.title,
    @required String setting,
    SettingType type = SettingType.SYSTEM,
    this.icon,
    @required DropdownOptions options,
    String minVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.description = null,
        this.setting = SettingKey<String>(setting, type),
        super._(minVersion, dependencies);
}

@immutable
class ActivityPreference extends Preference {
  final String title;
  final String description;
  final SmartIconData icon;
  final String cls;
  final String pkg;

  ActivityPreference({
    @required this.title,
    this.description,
    this.icon,
    @required this.cls,
    @required this.pkg,
    String minValue,
    List<Dependency> dependencies = const [],
  }) : super._(minValue, dependencies);
}

@immutable
class CustomPreference extends Preference {
  final String id;

  CustomPreference({
    @required this.id,
    String minValue,
    List<Dependency> dependencies = const [],
  }) : super._(minValue, dependencies);
}

@immutable
abstract class Options<T> {
  final T defaultValue;

  Options._(this.defaultValue);

  Map<String, dynamic> toJsonInternal() {
    return {
      'default': defaultValue,
    }..addAll(toJson());
  }

  Map<String, dynamic> toJson() => {};
}

class SwitchOptions extends Options<bool> {
  SwitchOptions({bool defaultValue = false}) : super._(defaultValue);
}

@immutable
class SliderOptions extends Options<int> {
  final int min;
  final int max;
  final bool percentage;

  SliderOptions({
    this.min = 0,
    @required this.max,
    this.percentage = false,
    int defaultValue = 0,
  }) : super._(defaultValue);

  @override
  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'percentage': percentage,
    };
  }
}

@immutable
class DropdownOptions extends Options<String> {
  final Map<String, String> values;

  DropdownOptions({
    @required this.values,
    String defaultValue,
  }) : super._(defaultValue ?? values.keys.first);

  @override
  Map<String, dynamic> toJson() {
    return {
      'values': values,
    };
  }
}

@immutable
class Dependency<T extends BaseKey> {
  final T key;
  final dynamic _value;

  get value => _value;

  Dependency(this.key, this._value);
}

@immutable
class SettingDependency extends Dependency<SettingKey> {
  @override
  get value {
    switch (key.valueType) {
      case SettingValueType.STRING:
        return _value as String;
      case SettingValueType.INT:
        return _value as int;
      case SettingValueType.BOOLEAN:
        return _value as bool;
    }
  }

  SettingDependency.string({
    @required String name,
    SettingType type = SettingType.SYSTEM,
    @required String value,
  }) : super(SettingKey<String>(name, type), value);

  SettingDependency.int({
    @required String name,
    SettingType type = SettingType.SYSTEM,
    @required int value,
  }) : super(SettingKey<int>(name, type), value);

  SettingDependency.boolean({
    @required String name,
    SettingType type = SettingType.SYSTEM,
    @required bool value,
  }) : super(SettingKey<bool>(name, type), value);
}

@immutable
class PropDependency extends Dependency<PropKey> {
  PropDependency({
    @required String name,
    @required bool value,
  }) : super(PropKey(name), value);
}
