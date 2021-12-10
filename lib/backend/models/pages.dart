import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/ui/components/preferences/base.dart';
import 'package:potato_fries/ui/components/preferences/settings.dart';
import 'package:potato_fries/ui/components/separated_flex.dart';
import 'package:pub_semver/pub_semver.dart';

class FriesPage {
  final String title;
  final List<PageSection> sections;
  final IconData icon;
  final IconData selectedIcon;
  final Widget? header;

  const FriesPage({
    required this.title,
    required this.sections,
    required this.icon,
    required this.selectedIcon,
    this.header,
  });

  Widget build(BuildContext context) {
    final List<PageSection> _nonEmptySections = sections.where((e) {
      final List<Preference> validPreferences =
          e.getValidPreferences(context.register);

      return validPreferences.isNotEmpty;
    }).toList();

    return SeparatedFlex(
      separator: const SizedBox(height: 16),
      children: [
        if (header != null)
          AspectRatio(
            aspectRatio: 20 / 9, // 20 : 9
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox.expand(child: header),
            ),
          ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                _nonEmptySections[index].build(context),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: _nonEmptySections.length,
            padding: EdgeInsets.only(top: header != null ? 16 : 0),
          ),
        ),
      ],
    );
  }

  NavigationDestination get destination => NavigationDestination(
        icon: Icon(icon),
        selectedIcon: Icon(selectedIcon),
        label: title,
      );

  List<Preference> get preferences =>
      sections.expand((s) => s.preferences).toList();

  ScrapeInfo scrape() {
    final Iterable<ScrapeInfo> scrapeInfo = sections.map((e) => e.scrape());

    return ScrapeInfo(
      scrapeInfo.expand((e) => e.settings).toList(),
      scrapeInfo.expand((e) => e.properties).toList(),
    );
  }
}

class PageSection {
  final String title;
  final List<Preference> preferences;

  const PageSection({
    required this.title,
    required this.preferences,
  });

  Widget build(BuildContext context) {
    final List<Preference> validPreferences =
        getValidPreferences(context.register);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            title,
            style: context.theme.textTheme.titleSmall!.copyWith(
              color: context.theme.colorScheme.primary,
            ),
          ),
        ),
        ...validPreferences.map((e) => e.build(context)),
      ],
    );
  }

  List<Preference> getValidPreferences(PropertyRegister register) {
    final List<Preference> validPreferences = [];
    for (final Preference preference in preferences) {
      final bool propDepsSatisfied = _validatePropDependencies(
        register,
        preference.dependencies.whereType<PropertyDependency>().toList(),
      );
      final bool versionConstrained =
          preference.versionRange.allows(Version.parse(register.vernum));

      if (propDepsSatisfied && versionConstrained) {
        validPreferences.add(preference);
      }
    }

    return preferences;
  }

  bool _validatePropDependencies(
    PropertyRegister register,
    List<PropertyDependency> dependencies,
  ) {
    bool result = true;

    for (final PropertyDependency dep in dependencies) {
      result = result && dep.value == register.get(dep.key);
    }

    return result;
  }

  ScrapeInfo scrape() {
    final Iterable<ScrapeInfo> scrapeInfo = preferences.map((e) => e.scrape());

    return ScrapeInfo(
      scrapeInfo.expand((e) => e.settings).toList(),
      scrapeInfo.expand((e) => e.properties).toList(),
    );
  }
}

abstract class Preference {
  final String title;
  final String? description;
  final IconData? icon;
  final List<Dependency> dependencies;
  final String? minVersion;
  final String? maxVersion;

  const Preference({
    required this.title,
    required this.description,
    required this.icon,
    required this.dependencies,
    required this.minVersion,
    required this.maxVersion,
  });

  Widget build(BuildContext context);

  VersionRange get versionRange => VersionRange(
        min: minVersion != null ? Version.parse(minVersion!) : null,
        max: maxVersion != null ? Version.parse(maxVersion!) : null,
        includeMin: true,
        includeMax: true,
      );

  ScrapeInfo scrape() {
    final Iterable<SettingDependency> settingDeps =
        dependencies.whereType<SettingDependency>();
    final Iterable<PropertyDependency> propertyDeps =
        dependencies.whereType<PropertyDependency>();

    return ScrapeInfo(
      settingDeps.map<Setting>((e) => e.key).toList(),
      propertyDeps.map<PropertyKey>((e) => e.key).toList(),
    );
  }
}

abstract class SettingPreference<T> extends Preference {
  final Setting<T> setting;

  const SettingPreference({
    required this.setting,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  ScrapeInfo scrape() {
    final ScrapeInfo superInfo = super.scrape();

    return ScrapeInfo(
      [...superInfo.settings, setting],
      superInfo.properties,
    );
  }
}

class SwitchSettingPreference extends SettingPreference<bool> {
  const SwitchSettingPreference({
    required Setting<bool> setting,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  Widget build(BuildContext context) {
    return SwitchSettingPreferenceTile(
      setting: setting,
      title: title,
      subtitle: description,
      icon: icon,
      dependencies: dependencies.whereType<SettingDependency>().toList(),
    );
  }
}

class SliderSettingPreference<T extends num> extends SettingPreference<T> {
  final T? min;
  final T max;

  const SliderSettingPreference({
    required Setting<T> setting,
    required String title,
    String? description,
    this.min,
    required this.max,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  Widget build(BuildContext context) {
    return SliderSettingPreferenceTile<T>(
      setting: setting,
      title: title,
      min: min,
      max: max,
      icon: icon,
      dependencies: dependencies.whereType<SettingDependency>().toList(),
    );
  }
}

class DropdownSettingPreference<K> extends SettingPreference<K> {
  final Map<K, String> options;

  const DropdownSettingPreference({
    required Setting<K> setting,
    required String title,
    String? description,
    required this.options,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  Widget build(BuildContext context) {
    return DropdownSettingPreferenceTile<K>(
      setting: setting,
      title: title,
      options: options,
      icon: icon,
      dependencies: dependencies.whereType<SettingDependency>().toList(),
    );
  }
}

class ColorSettingPreference extends SettingPreference<dynamic> {
  final ColorPreferenceType type;

  const ColorSettingPreference.asRgb({
    required Setting<int> setting,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  })  : type = ColorPreferenceType.rgb,
        super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  const ColorSettingPreference.asHex({
    required Setting<String> setting,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  })  : type = ColorPreferenceType.hex,
        super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  Widget build(BuildContext context) {
    return ColorSettingPreferenceTile(
      setting: setting,
      title: title,
      type: type,
      subtitle: description,
      icon: icon,
      dependencies: dependencies.whereType<SettingDependency>().toList(),
    );
  }
}

class FriesSubpage {
  final String title;
  final List<Preference> preferences;

  const FriesSubpage({
    required this.title,
    required this.preferences,
  });

  Widget build(BuildContext context) {
    assert(preferences.every((element) => element is! SubpagePreference));

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => preferences[index].build(context),
        itemCount: preferences.length,
      ),
    );
  }

  ScrapeInfo scrape() {
    final Iterable<ScrapeInfo> scrapeInfo = preferences.map((e) => e.scrape());

    return ScrapeInfo(
      scrapeInfo.expand((e) => e.settings).toList(),
      scrapeInfo.expand((e) => e.properties).toList(),
    );
  }
}

class SubpagePreference extends Preference {
  final FriesSubpage subpage;

  const SubpagePreference({
    required this.subpage,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );

  @override
  Widget build(BuildContext context) {
    return SettingDependencyHandler(
      dependencies: dependencies.whereType<SettingDependency>().toList(),
      builder: (context, dependencyEnable) => PreferenceTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: description != null ? Text(description!) : null,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => subpage.build(context),
          ),
        ),
        trailing: const ShortChip(child: Icon(Icons.chevron_right)),
        enabled: dependencyEnable,
      ),
    );
  }

  @override
  ScrapeInfo scrape() {
    final ScrapeInfo superInfo = super.scrape();
    final ScrapeInfo subpageInfo = subpage.scrape();

    return ScrapeInfo(
      [...superInfo.settings, ...subpageInfo.settings],
      [...superInfo.properties, ...subpageInfo.properties],
    );
  }
}

class ScrapeInfo {
  final List<Setting> settings;
  final List<PropertyKey> properties;

  const ScrapeInfo(this.settings, this.properties);

  @override
  int get hashCode => Object.hash(settings, properties);

  @override
  bool operator ==(Object other) {
    if (other is ScrapeInfo) {
      const ListEquality eq = ListEquality();
      return eq.equals(settings, other.settings) &&
          eq.equals(properties, other.properties);
    }

    return false;
  }
}
