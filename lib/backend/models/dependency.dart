import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';

abstract class Dependency<T> {
  final T key;
  final dynamic value;

  const Dependency(this.key, this.value);
}

class SettingDependency<T> extends Dependency<SettingKey<T>> {
  const SettingDependency(SettingKey<T> key, T value) : super(key, value);
}

class PropertyDependency extends Dependency<PropertyKey> {
  const PropertyDependency(PropertyKey key, String? value) : super(key, value);
}
