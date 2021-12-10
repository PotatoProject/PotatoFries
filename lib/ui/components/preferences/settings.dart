import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/ui/components/preferences/base.dart';
import 'package:potato_fries/ui/components/preferences/color.dart';
import 'package:potato_fries/ui/components/sheet.dart';

class SwitchSettingPreferenceTile extends StatelessWidget {
  final SettingKey<bool> setting;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<SettingDependency> dependencies;

  const SwitchSettingPreferenceTile({
    required this.setting,
    required this.title,
    this.subtitle,
    this.icon,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTileBase<bool>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) => SwitchPreferenceTile(
        icon: Icon(icon),
        title: title,
        subtitle: subtitle,
        value: value,
        onValueChanged: (value) => setting.write(value),
        enabled: dependencyEnable,
        onLongPress: () => _resetSetting(context, setting),
      ),
    );
  }
}

class SliderSettingPreferenceTile<T extends num> extends StatefulWidget {
  final SettingKey<T> setting;
  final String title;
  final T? min;
  final T max;
  final IconData? icon;
  final List<SettingDependency> dependencies;

  const SliderSettingPreferenceTile({
    required this.setting,
    required this.title,
    this.min,
    required this.max,
    this.icon,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  _SliderSettingPreferenceTileState<T> createState() =>
      _SliderSettingPreferenceTileState<T>();
}

class _SliderSettingPreferenceTileState<T extends num>
    extends State<SliderSettingPreferenceTile<T>> {
  late T value = context.sink.read<T>(widget.setting)!;

  @override
  Widget build(BuildContext context) {
    return SettingTileBase<T>(
      setting: widget.setting,
      dependencies: widget.dependencies,
      builder: (context, value, dependencyEnable) {
        return SliderPreferenceTile<T>(
          icon: Icon(widget.icon),
          title: widget.title,
          min: widget.min ?? 0 as T,
          max: widget.max,
          value: this.value,
          onValueChanged: (value) => setState(() => this.value = value),
          onValueChangeEnd: (value) async {
            await widget.setting.write(value);
            this.value = value;
          },
          enabled: dependencyEnable,
          onLongPress: () async {
            final bool confirmed = await _resetSetting(context, widget.setting);

            if (confirmed) {
              final T value = context.sink.defaultValueFor<T>(widget.setting)!;
              setState(() => this.value = value);
            }
          },
        );
      },
    );
  }
}

class DropdownSettingPreferenceTile<K> extends StatelessWidget {
  final SettingKey<K> setting;
  final Map<K, String> options;
  final String title;
  final IconData? icon;
  final List<SettingDependency> dependencies;

  const DropdownSettingPreferenceTile({
    required this.setting,
    required this.title,
    required this.options,
    this.icon,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTileBase<K>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) => DropdownPreferenceTile<K>(
        icon: Icon(icon),
        title: title,
        options: options,
        selectedOption: value,
        onValueChanged: (value) => setting.write(value),
        enabled: dependencyEnable,
        onLongPress: () => _resetSetting(context, setting),
      ),
    );
  }
}

class ColorSettingPreferenceTile extends StatelessWidget {
  final SettingKey<dynamic> setting;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<SettingDependency> dependencies;
  final ColorPreferenceType type;

  const ColorSettingPreferenceTile({
    required this.setting,
    required this.title,
    required this.type,
    this.subtitle,
    this.icon,
    this.dependencies = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTileBase<dynamic>(
      setting: setting,
      dependencies: dependencies,
      builder: (context, value, dependencyEnable) {
        final int color;

        switch (type) {
          case ColorPreferenceType.rgb:
            color = value;
            break;
          case ColorPreferenceType.hex:
            color = int.parse(
              value.replaceFirst("#", ""),
              radix: 16,
            );
            break;
        }

        return ColorPickerPreferenceTile(
          icon: Icon(icon),
          title: title,
          color: HSLColor.fromColor(Color(color).withOpacity(1)),
          onColorChanged: (value) async {
            final Object settingValue;

            switch (type) {
              case ColorPreferenceType.rgb:
                final Color color = value.toColor();

                settingValue =
                    (color.red << 16 | color.green << 8 | color.blue << 0) &
                        0xFFFFFFFF;
                break;
              case ColorPreferenceType.hex:
                settingValue =
                    "#${value.toColor().value.toRadixString(16).substring(2)}";
                break;
            }

            await setting.write(settingValue);
          },
          enabled: dependencyEnable,
          onLongPress: () => _resetSetting(context, setting),
        );
      },
    );
  }
}

enum ColorPreferenceType {
  hex,
  rgb,
}

typedef _SettingTileBuilder<T> = Widget Function(
  BuildContext context,
  T value,
  bool dependencyEnable,
);

class SettingTileBase<T> extends StatefulWidget {
  final SettingKey<T> setting;
  final List<SettingDependency> dependencies;
  final _SettingTileBuilder<T> builder;

  const SettingTileBase({
    required this.setting,
    required this.dependencies,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _SettingTileBaseState<T> createState() => _SettingTileBaseState<T>();
}

class _SettingTileBaseState<T> extends State<SettingTileBase<T>> {
  late final SettingSubscription<T> subscription =
      context.sink.getSubscription<T>(widget.setting)!;

  @override
  Widget build(BuildContext context) {
    return SettingListener<T>(
      subscription: subscription,
      builder: (context, value) => SettingDependencyHandler(
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

class SettingDependencyHandler extends StatefulWidget {
  final List<SettingDependency> dependencies;
  final Widget Function(BuildContext context, bool dependenciesSatisfied)
      builder;

  const SettingDependencyHandler({
    required this.dependencies,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  _SettingDependencyHandlerState createState() =>
      _SettingDependencyHandlerState();
}

class _SettingDependencyHandlerState extends State<SettingDependencyHandler> {
  final Map<SettingKey, SettingSubscription> subscriptions = {};
  static const ListEquality _eq = ListEquality();

  @override
  void initState() {
    super.initState();
    _registerListeners();
  }

  @override
  void didUpdateWidget(covariant SettingDependencyHandler old) {
    if (!_eq.equals(widget.dependencies, old.dependencies)) {
      _unregisterListeners();
      _registerListeners();
    }

    super.didUpdateWidget(old);
  }

  void _registerListeners() {
    subscriptions.clear();
    for (final SettingDependency dependency in widget.dependencies) {
      final SettingSubscription subscription =
          context.sink.getSubscription(dependency.key)!;
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
    if (mounted) setState(() {});
  }

  bool _checkForDependencies() {
    bool result = true;

    for (final SettingDependency dep in widget.dependencies) {
      result = result && dep.value == subscriptions[dep.key]!.value;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _checkForDependencies());
}

Future<bool> _resetSetting<T>(
  BuildContext context,
  SettingKey<T> setting,
) async {
  final bool? settingResetConfirmation = await context.showBottomSheet<bool>(
    builder: (context) => DialogSheet(
      title: const Text("Reset the setting to the defaults?"),
      content: const Text("The operation can't be undone. Continue?"),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Continue"),
        ),
      ],
    ),
  );

  if (settingResetConfirmation == true) {
    await setting.write(null);
  }

  return settingResetConfirmation == true;
}
