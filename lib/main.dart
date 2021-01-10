import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/locales/generated_asset_loader.g.dart';
import 'package:potato_fries/locales/locales.g.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/utils/custom_widget_registry.dart';
import 'package:potato_fries/widgets/custom/accent_picker.dart';
import 'package:potato_fries/widgets/custom/icon_pack_picker.dart';
import 'package:potato_fries/widgets/custom/icon_shape_picker.dart';
import 'package:potato_fries/widgets/custom/lock_screen_clock_picker.dart';
import 'package:provider/provider.dart';
import 'package:spicy_components/spicy_components.dart';

void main() {
  CustomWidgetRegistry.register(AccentPicker());
  CustomWidgetRegistry.register(IconPackPicker());
  CustomWidgetRegistry.register(IconShapePicker());
  CustomWidgetRegistry.register(LockScreenClockPicker());

  runApp(
    EasyLocalization(
      child: FriesRoot(),
      supportedLocales: Locales.supported,
      fallbackLocale: Locale("en", "US"),
      assetLoader: GeneratedAssetLoader(),
      path: "assets/locales",
    ),
  );
}

class FriesRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppInfoProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      builder: (context, _) {
        var appInfoProvider = Provider.of<AppInfoProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fries',
          theme: SpicyThemes.light(appInfoProvider.accentLight).copyWith(
            canvasColor: SpicyThemes.light(appInfoProvider.accentLight)
                .scaffoldBackgroundColor,
          ),
          darkTheme: SpicyThemes.dark(appInfoProvider.accentDark).copyWith(
            canvasColor: SpicyThemes.dark(appInfoProvider.accentLight)
                .scaffoldBackgroundColor,
          ),
          home: FriesHome(),
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
        );
      },
    );
  }
}
