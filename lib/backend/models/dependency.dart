import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';

sealed class Dependency<K, V> {
  final K key;
  final V value;

  const Dependency(this.key, this.value);
}

class SettingDependency<T> extends Dependency<Setting<T>, T> {
  const SettingDependency(super.key, super.value);
}

class PropertyDependency extends Dependency<PropertyKey, String?> {
  const PropertyDependency(super.key, super.value);
}
