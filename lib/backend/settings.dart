import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:provider/provider.dart';

class SettingSink {
  static const _eventChannel = EventChannel("fries/settings/sink");
  final Stream<String> _events;
  final Set<SettingSubscription> _subscriptions = {};

  SettingSink.newInstance()
      : _events = _eventChannel.receiveBroadcastStream().cast<String>() {
    _events.listen(_onEvent);
  }

  static SettingSink of(BuildContext context) {
    return Provider.of<SettingSink>(context, listen: false);
  }

  void _onEvent(String event) {
    final List<String> eventParts = event.split("\u2022");
    final String uri = eventParts.first;
    final String value = eventParts.last;

    final SettingSubscription? subscription =
        _subscriptions.firstWhereOrNull((s) => s.uri == Uri.parse(uri));
    subscription?._notifyValue(value);
  }

  Future<SettingSubscription<T>> subscribe<T>(Setting<T> setting) async {
    assert(
      setting.defaultValue is String ||
          setting.defaultValue is int ||
          setting.defaultValue is double ||
          setting.defaultValue is bool,
    );
    final String defaultValueStr;

    if (setting.defaultValue is bool) {
      defaultValueStr = (setting.defaultValue as bool) ? "1" : "0";
    } else {
      defaultValueStr = setting.defaultValue.toString();
    }

    final SettingSubscription<T> subscription = SettingSubscription<T>._new(
      setting,
      _deriveTypeFromTValue(setting.defaultValue),
    );

    _subscriptions.add(subscription);

    await SettingKey.controlsChannel.invokeMethod("subscribe", {
      "uri": subscription.uri.toString(),
      "defaultValue": defaultValueStr,
    });

    return subscription;
  }

  SettingSubscription<T>? getSubscription<T>(SettingKey<T> key) {
    return _subscriptions.firstWhereOrNull(
      (s) => s.uri == key.uri,
    ) as SettingSubscription<T>?;
  }

  Future<SettingSubscription<T>> getSubscriptionOrSubscribe<T>(
    Setting<T> setting,
  ) async {
    SettingSubscription<T>? subscription = getSubscription<T>(setting);
    subscription ??= await subscribe(setting);

    return subscription;
  }

  SettingType _deriveTypeFromTValue<T>(T value) {
    switch (value.runtimeType) {
      case String:
        return SettingType.string;
      case int:
        return SettingType.integer;
      case double:
        return SettingType.float;
      case bool:
        return SettingType.boolean;
      default:
        throw ArgumentError(
          "Type ${value.runtimeType} is not supported for settings",
        );
    }
  }
}

class SettingSubscription<T> extends ChangeNotifier {
  final SettingKey<T> key;
  final SettingType type;
  late T value;

  SettingSubscription._new(this.key, this.type);

  Uri get uri => key.uri;

  void _notifyValue(String value) {
    this.value = type._applyToValFromSink(value) as T;
    notifyListeners();
  }
}

extension on SettingType {
  Object _applyToValFromSink(String value) {
    switch (this) {
      case SettingType.string:
        return value;
      case SettingType.boolean:
        if (value == "1") {
          return true;
        } else if (value == "0") {
          return false;
        } else {
          throw Exception('Can\'t convert value "$value" to $name');
        }
      case SettingType.integer:
        final int? intValue = int.tryParse(value);

        if (intValue == null) {
          throw Exception('Can\'t convert value "$value" to $name');
        }

        return intValue;
      case SettingType.float:
        final double? doubleValue = double.tryParse(value);

        if (doubleValue == null) {
          throw Exception('Can\'t convert value "$value" to $name');
        }

        return doubleValue;
    }
  }
}
