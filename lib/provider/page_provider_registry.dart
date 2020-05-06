import 'package:potato_fries/provider/page_provider.dart';

Map<String, PageProvider> _registry = {};

class PageProviderRegistry {
  static PageProvider getProvider(String key) {
    PageProvider provider = _registry[key];

    if(provider != null) {
      return provider;
    } else {
      PageProvider newProvider = PageProvider(key);
      _registry.addAll({
        key: newProvider,
      });
      return newProvider;
    }
  }
}