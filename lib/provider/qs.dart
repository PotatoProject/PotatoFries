import 'package:potato_fries/provider/page_provider.dart';

class QSProvider extends PageProvider {
  static const String qsProviderKey = 'qs';

  QSProvider({String providerKey = qsProviderKey})
      : assert(providerKey == qsProviderKey),
        super(qsProviderKey);
}
