import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/ui/components/preferences/base.dart';
import 'package:potato_fries/ui/components/preferences/settings.dart';
import 'package:potato_fries/ui/components/separated_flex.dart';
import 'package:potato_fries/ui/theme.dart';
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
            itemBuilder: (context, index) => sections[index].build(context),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: sections.length,
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
}

class PageSection {
  final String title;
  final List<Preference> preferences;

  const PageSection({
    required this.title,
    required this.preferences,
  });

  Widget build(BuildContext context) {
    final FriesThemeData theme = FriesTheme.of(context);

    final List<Preference> validPreferences = [];
    for (final Preference preference in preferences) {
      final bool propDepsSatisfied = _validatePropDependencies(
        context.register,
        preference.dependencies.whereType<PropertyDependency>().toList(),
      );
      final bool versionConstrained = preference.versionRange.allows(
        Version.parse(context.register.vernum),
      );

      if (propDepsSatisfied && versionConstrained) {
        validPreferences.add(preference);
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Text(
            title,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...validPreferences.map((e) => e.build(context)),
      ],
    );
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
}

abstract class Preference {
  final List<Dependency> dependencies;
  final String? minVersion;
  final String? maxVersion;

  const Preference({
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
}

abstract class SettingPreference<T> extends Preference {
  final Setting<T> setting;
  final String title;
  final String? description;
  final IconData? icon;

  const SettingPreference({
    required this.setting,
    required this.title,
    this.description,
    this.icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
          dependencies: dependencies,
          minVersion: minVersion,
          maxVersion: maxVersion,
        );
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
}

class SubpagePreference extends Preference {
  final FriesSubpage subpage;
  final String title;
  final String? description;
  final IconData? icon;

  const SubpagePreference({
    required this.subpage,
    required this.title,
    this.description,
    this.icon,
    List<Dependency> dependencies = const [],
    String? minVersion,
    String? maxVersion,
  }) : super(
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
}
