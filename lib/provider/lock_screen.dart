import 'package:potato_fries/provider/page_provider.dart';

class LockScreenProvider extends PageProvider {
  static const String lockScreenProviderKey = 'lock_screen';

  LockScreenProvider({String providerKey = lockScreenProviderKey})
      : assert(providerKey == lockScreenProviderKey),
        super(lockScreenProviderKey);
}
