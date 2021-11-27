import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/ui/components/preferences/settings.dart';
import 'package:potato_fries/ui/theme.dart';

class FriesPage {
  final String title;
  final List<PageSection> sections;
  final IconData icon;
  final IconData selectedIcon;
  final WidgetBuilder? header;

  const FriesPage({
    required this.title,
    required this.sections,
    required this.icon,
    required this.selectedIcon,
    this.header,
  });

  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => sections[index].build(context),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: sections.length,
    );
  }

  NavigationDestination get destination => NavigationDestination(
        icon: Icon(icon),
        selectedIcon: Icon(selectedIcon),
        label: title,
      );
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
    final PropertyRegister register =
        PropertyRegister.of(context, listen: false);

    final List<Preference> validPreferences = [];
    for (final Preference preference in preferences) {
      if (_validatePropDependencies(
        register,
        preference.dependencies.whereType<PropertyDependency>().toList(),
      )) {
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

  const Preference({
    required this.dependencies,
  });

  Widget build(BuildContext context);
}

abstract class _SettingPreference<T> extends Preference {
  final SettingKey<T> setting;
  final String title;
  final String? description;
  final IconData? icon;

  const _SettingPreference({
    required this.setting,
    required this.title,
    this.description,
    this.icon,
    List<Dependency> dependencies = const [],
  }) : super(dependencies: dependencies);
}

class SwitchSettingPreference extends _SettingPreference<bool> {
  const SwitchSettingPreference({
    required SettingKey<bool> setting,
    required String title,
    String? description,
    IconData? icon,
    List<Dependency> dependencies = const [],
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
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

class SliderSettingPreference<T extends num> extends _SettingPreference<T> {
  final T? min;
  final T max;

  const SliderSettingPreference({
    required SettingKey<T> setting,
    required String title,
    String? description,
    this.min,
    required this.max,
    IconData? icon,
    List<Dependency> dependencies = const [],
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
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

class DropdownSettingPreference<K> extends _SettingPreference<K> {
  final Map<K, String> options;

  const DropdownSettingPreference({
    required SettingKey<K> setting,
    required String title,
    String? description,
    required this.options,
    IconData? icon,
    List<Dependency> dependencies = const [],
  }) : super(
          setting: setting,
          title: title,
          description: description,
          icon: icon,
          dependencies: dependencies,
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
