import 'package:potato_fries/provider/page_provider.dart';

class MiscProvider extends PageProvider {
  static const String miscProviderKey = 'misc';

  MiscProvider({String providerKey = miscProviderKey})
      : assert(providerKey == miscProviderKey),
        super(miscProviderKey);
}
