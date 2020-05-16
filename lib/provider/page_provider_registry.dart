import 'package:potato_fries/provider/buttons.dart';
import 'package:potato_fries/provider/lock_screen.dart';
import 'package:potato_fries/provider/misc.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/provider/status_bar.dart';
import 'package:potato_fries/provider/themes.dart';

Map<String, PageProvider> _registry = {
  ButtonsProvider.buttonsProviderKey: ButtonsProvider(),
  LockScreenProvider.lockScreenProviderKey: LockScreenProvider(),
  MiscProvider.miscProviderKey: MiscProvider(),
  QSProvider.qsProviderKey: QSProvider(),
  StatusBarProvider.statusBarProviderKey: StatusBarProvider(),
  ThemesProvider.themesProviderKey: ThemesProvider(),
};

class PageProviderRegistry {
  static PageProvider getProvider(String key) {
    PageProvider provider = _registry[key];

    if (provider != null) {
      return provider;
    } else {
      PageProvider newProvider = PageProvider(key);
      _registry[key] = newProvider;
      return newProvider;
    }
  }
}
