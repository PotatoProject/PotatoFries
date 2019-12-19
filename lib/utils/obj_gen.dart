library class_builder;

typedef T C<T>();

class ObjectGen {
  static Map<String, C<Object>> _c = <String, C<Object>>{};

  static void register<T>(C<T> c) => _c[T.toString()] = c;

  static dynamic fromString(String type) => _c[type]();
}
