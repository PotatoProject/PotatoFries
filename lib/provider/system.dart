import 'package:potato_fries/provider/page_provider.dart';

class SystemProvider extends PageProvider {
  static const String systemProviderKey = 'system';

  SystemProvider({String providerKey = systemProviderKey})
      : assert(providerKey == systemProviderKey),
        super(systemProviderKey);
}
