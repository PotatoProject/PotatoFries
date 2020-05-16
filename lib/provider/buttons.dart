import 'package:potato_fries/provider/page_provider.dart';

class ButtonsProvider extends PageProvider {
  static const String buttonsProviderKey = 'buttons_and_gestures';

  ButtonsProvider({String providerKey = buttonsProviderKey})
      : assert(providerKey == buttonsProviderKey),
        super(buttonsProviderKey);
}
