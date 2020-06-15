import 'package:potato_fries/provider/page_provider.dart';

class ThemesProvider extends PageProvider {
  static const String themesProviderKey = 'themes';

  ThemesProvider({String providerKey = themesProviderKey})
      : assert(providerKey == themesProviderKey),
        super(themesProviderKey);
}
