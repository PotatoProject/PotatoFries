import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/ui/components/preferences/base.dart';

class SwitchSettingPreference extends StatelessWidget {
  final SettingKey<bool> setting;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool enabled;
  final List<Dependency> dependencies;

  const SwitchSettingPreference({
    required this.setting,
    required this.title,
    this.subtitle,
    this.icon,
    this.enabled = true,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingTileBase<bool>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) => SwitchPreferenceTile(
        icon: Icon(icon),
        title: title,
        value: value,
        onValueChanged: (value) => setting.write(value),
        enabled: enabled && dependencyEnable,
        onLongPress: () => _resetSetting(context, setting),
      ),
    );
  }
}

class SliderSettingPreference<T extends num> extends StatelessWidget {
  final SettingKey<T> setting;
  final String title;
  final T? min;
  final T max;
  final IconData? icon;
  final bool enabled;
  final List<Dependency> dependencies;

  const SliderSettingPreference({
    required this.setting,
    required this.title,
    this.min,
    required this.max,
    this.icon,
    this.enabled = true,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingTileBase<T>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) => SliderPreferenceTile<T>(
        icon: Icon(icon),
        title: title,
        min: min ?? 0 as T,
        max: max,
        value: value,
        onValueChanged: (value) => setting.write(value),
        enabled: enabled && dependencyEnable,
        onLongPress: () => _resetSetting(context, setting),
      ),
    );
  }
}

class DropdownSettingPreference<K> extends StatelessWidget {
  final SettingKey<K> setting;
  final Map<K, String> options;
  final String title;
  final IconData? icon;
  final bool enabled;
  final List<Dependency> dependencies;

  const DropdownSettingPreference({
    required this.setting,
    required this.title,
    required this.options,
    this.icon,
    this.enabled = true,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SettingTileBase<K>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) => DropdownPreferenceTile<K>(
        icon: Icon(icon),
        title: title,
        options: options,
        selectedOption: value,
        onValueChanged: (value) => setting.write(value),
        enabled: enabled && dependencyEnable,
        onLongPress: () => _resetSetting(context, setting),
      ),
    );
  }
}

typedef _SettingTileBuilder<T> = Widget Function(
  BuildContext context,
  T value,
  bool dependencyEnable,
);

class _SettingTileBase<T> extends StatefulWidget {
  final SettingKey<T> setting;
  final List<Dependency> dependencies;
  final _SettingTileBuilder builder;

  const _SettingTileBase({
    required this.setting,
    required this.dependencies,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _SettingTileBaseState<T> createState() => _SettingTileBaseState<T>();
}

class _SettingTileBaseState<T> extends State<_SettingTileBase<T>> {
  late final SettingSink sink = SettingSink.of(context, listen: false);
  late final SettingSubscription<T> subscription =
      sink.getSubscription<T>(widget.setting)!;

  @override
  Widget build(BuildContext context) {
    return SettingListener<T>(
      subscription: subscription,
      builder: (context, value) => DependencyHandler(
        dependencies: widget.dependencies,
        builder: (context, enable) => widget.builder(context, value, enable),
      ),
    );
  }
}

class SettingListener<T> extends StatefulWidget {
  final SettingSubscription<T> subscription;
  final Widget Function(BuildContext context, T value) builder;

  const SettingListener({
    required this.subscription,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _SettingListenerState<T> createState() => _SettingListenerState<T>();
}

class _SettingListenerState<T> extends State<SettingListener<T>> {
  @override
  void initState() {
    super.initState();
    widget.subscription.addListener(_update);
  }

  @override
  void dispose() {
    widget.subscription.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.subscription.value);
}

class DependencyHandler extends StatefulWidget {
  final List<Dependency> dependencies;
  final Widget Function(BuildContext context, bool dependenciesSatisfied)
      builder;

  const DependencyHandler({
    required this.dependencies,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _DependencyHandlerState createState() => _DependencyHandlerState();
}

class _DependencyHandlerState extends State<DependencyHandler> {
  late final SettingSink sink = SettingSink.of(context, listen: false);
  List<SettingDependency> get settingDependencies =>
      widget.dependencies.whereType<SettingDependency>().toList();
  final Map<SettingKey, SettingSubscription> subscriptions = {};

  @override
  void initState() {
    super.initState();
    _registerListeners();
  }

  @override
  void didUpdateWidget(covariant DependencyHandler old) {
    const ListEquality eq = ListEquality(ListEquality());
    if (!eq.equals(widget.dependencies, old.dependencies)) {
      _unregisterListeners();
      _registerListeners();
    }

    super.didUpdateWidget(old);
  }

  void _registerListeners() {
    subscriptions.clear();
    for (final SettingDependency dependency in settingDependencies) {
      final SettingSubscription subscription =
          sink.getSubscription(dependency.key)!;
      subscription.addListener(_update);
      subscriptions[dependency.key] = subscription;
    }
  }

  void _unregisterListeners() {
    for (final SettingSubscription element in subscriptions.values) {
      element.removeListener(_update);
    }
  }

  void _update() {
    setState(() {});
  }

  bool _checkForDependencies() {
    bool result = true;

    for (final Dependency dep in widget.dependencies) {
      if (dep is SettingDependency) {
        result = result && dep.value == subscriptions[dep.key]!.value;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _checkForDependencies());
}

Future<void> _resetSetting<T>(
  BuildContext context,
  SettingKey<T> setting,
) async {
  final bool? settingResetConfirmation = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Reset the setting to the defaults?"),
      content: const Text("The operation can't be undone. Continue?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Continue"),
        ),
      ],
    ),
  );

  if (settingResetConfirmation == true) {
    setting.write(null);
  }
}
