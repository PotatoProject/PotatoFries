import 'package:potato_fries/backend/models/settings.dart';

abstract class Dependency<T> {
  final T key;
  final dynamic value;

  const Dependency(this.key, this.value);
}

class SettingDependency<T> extends Dependency<SettingKey> {
  const SettingDependency(SettingKey<T> key, T value) : super(key, value);
}
