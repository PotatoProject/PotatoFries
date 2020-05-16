import 'package:potato_fries/provider/page_provider.dart';

class StatusBarProvider extends PageProvider {
  static const String statusBarProviderKey = 'status_bar';

  StatusBarProvider({String providerKey = statusBarProviderKey})
      : assert(providerKey == statusBarProviderKey),
        super(statusBarProviderKey);
}
