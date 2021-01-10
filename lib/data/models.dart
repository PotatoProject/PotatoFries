import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:potato_fries/utils/custom_widget_registry.dart';
import 'package:potato_fries/widgets/activity_tile.dart';
import 'package:potato_fries/widgets/settings_dropdown.dart';
import 'package:potato_fries/widgets/settings_slider.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

@immutable
abstract class Preference {
  final VersionConstraint versionConstraint;
  final List<Dependency> dependencies;

  Preference._(
    this.versionConstraint,
    this.dependencies,
  );

  Widget toWidget(BuildContext context);
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
    String maxVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.setting = SettingKey<bool>(setting, type),
        super._(
          VersionConstraint(
            min: minVersion != null
                ? BuildVersion.parse(minVersion)
                : BuildVersion.empty,
            max: maxVersion != null
                ? BuildVersion.parse(maxVersion)
                : BuildVersion.empty,
          ),
          dependencies,
        );

  SettingPreference.withSlider({
    @required this.title,
    this.description,
    @required String setting,
    SettingType type = SettingType.SYSTEM,
    @required SliderOptions options,
    String minVersion,
    String maxVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.icon = null,
        this.setting = SettingKey<int>(setting, type),
        super._(
          VersionConstraint(
            min: minVersion != null
                ? BuildVersion.parse(minVersion)
                : BuildVersion.empty,
            max: maxVersion != null
                ? BuildVersion.parse(maxVersion)
                : BuildVersion.empty,
          ),
          dependencies,
        );

  SettingPreference.withDropdown({
    @required this.title,
    this.description,
    @required String setting,
    SettingType type = SettingType.SYSTEM,
    this.icon,
    @required DropdownOptions options,
    String minVersion,
    String maxVersion,
    List<Dependency> dependencies = const [],
  })  : this.options = options,
        this.setting = SettingKey<String>(setting, type),
        super._(
          VersionConstraint(
            min: minVersion != null
                ? BuildVersion.parse(minVersion)
                : BuildVersion.empty,
            max: maxVersion != null
                ? BuildVersion.parse(maxVersion)
                : BuildVersion.empty,
          ),
          dependencies,
        );

  @override
  Widget toWidget(BuildContext context) {
    switch (setting.valueType) {
      case SettingValueType.BOOLEAN:
        return SettingsSwitchTile(pref: this);
      case SettingValueType.INT:
        return SettingsSliderTile(pref: this);
      case SettingValueType.STRING:
      default:
        return SettingsDropdownTile(pref: this);
    }
  }
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
    String minVersion,
    String maxVersion,
    List<Dependency> dependencies = const [],
  }) : super._(
          VersionConstraint(
            min: minVersion != null
                ? BuildVersion.parse(minVersion)
                : BuildVersion.empty,
            max: maxVersion != null
                ? BuildVersion.parse(maxVersion)
                : BuildVersion.empty,
          ),
          dependencies,
        );

  @override
  Widget toWidget(BuildContext context) {
    return ActivityTile(
      title: title,
      subtitle: description,
      icon: SmartIcon(icon),
      cls: cls,
      pkg: pkg,
    );
  }
}

@immutable
class CustomPreference extends Preference {
  final String id;

  CustomPreference({
    @required this.id,
    String minVersion,
    String maxVersion,
    List<Dependency> dependencies = const [],
  }) : super._(
          VersionConstraint(
            min: minVersion != null
                ? BuildVersion.parse(minVersion)
                : BuildVersion.empty,
            max: maxVersion != null
                ? BuildVersion.parse(maxVersion)
                : BuildVersion.empty,
          ),
          dependencies,
        );

  @override
  Widget toWidget(BuildContext context) {
    return CustomWidgetRegistry.fromString(id);
  }
}

@immutable
abstract class Options<T> {
  final T defaultValue;

  Options._(this.defaultValue) : assert(defaultValue != null);

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
    @required String value,
  }) : super(PropKey(name), value);
}

@immutable
class BuildVersion {
  final int major;
  final int minor;
  final int patch;
  final String label;
  final int build;

  const BuildVersion(
    this.major,
    this.minor,
    this.patch, {
    this.label,
    this.build,
  });

  static const BuildVersion empty = BuildVersion(0, 0, 0);

  factory BuildVersion.parse(String verNum) {
    var exp = RegExp(
        r"^((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)$");
    if (!exp.hasMatch(verNum)) throw ArgumentError.value(verNum, 'vernum');

    String build;
    String version;
    if (verNum.contains('+')) {
      version = verNum.split('+')[0];
      build = verNum.split('+')[1];
    } else {
      version = verNum;
    }

    final _major = int.tryParse(version.split('.')[0]);
    final _minor = int.tryParse(version.split('.')[1]);
    final _patchWithLabel = version.split('.')[2];
    final _patch = int.tryParse(_patchWithLabel.split('-').first);
    final _label = _patchWithLabel.split('-').length > 1
        ? _patchWithLabel.split('-').last
        : null;
    final _build = build != null ? int.tryParse(build) : null;
    return BuildVersion(_major, _minor, _patch, label: _label, build: _build);
  }

  @override
  bool operator ==(Object other) {
    if (other is BuildVersion && other != null) {
      return this.major == other.major &&
          this.minor == other.minor &&
          this.patch == other.patch &&
          this.build == other.build;
    } else
      return false;
  }

  @override
  int get hashCode =>
      major.hashCode ^ minor.hashCode ^ patch.hashCode ^ build.hashCode;

  @override
  String toString() {
    return "$major.$minor.$patch${label != null ? "-$label" : ""}${build != null ? "+$build" : ""}";
  }
}

@immutable
class VersionConstraint {
  final BuildVersion min;
  final BuildVersion max;

  VersionConstraint({
    this.min = BuildVersion.empty,
    this.max = BuildVersion.empty,
  })  : assert(min != null),
        assert(max != null);

  bool isConstrained(BuildVersion target) {
    bool minSupported = false;
    bool maxSupported = false;

    if (min != BuildVersion.empty) {
      if (target.major >= min.major) {
        if (target.minor >= min.minor) {
          if (target.patch >= min.patch) minSupported = true;
        }
      }
    } else {
      minSupported = true;
    }

    if (max != BuildVersion.empty) {
      if (target.major <= max.major) {
        if (target.minor <= max.minor) {
          if (target.patch <= max.patch) maxSupported = true;
        }
      }
    } else {
      maxSupported = true;
    }

    return minSupported && maxSupported;
  }
}

@immutable
class Pages {
  final List<PageData> pages;

  const Pages(this.pages);

  PageData operator [](String key) {
    return pages.firstWhere(
      (p) => p.key == key,
      orElse: () => null,
    );
  }
}

@immutable
class PageData {
  final String key;
  final List<PageCategoryData> categories;

  const PageData({
    @required this.key,
    @required this.categories,
  });
}

@immutable
class PageCategoryData {
  final String title;
  final List<Preference> preferences;

  const PageCategoryData(
    this.title,
    this.preferences,
  );
}
