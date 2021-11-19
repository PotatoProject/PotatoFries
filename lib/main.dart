import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/locales/generated_asset_loader.g.dart';
import 'package:potato_fries/locales/locales.g.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/themes.dart';
import 'package:potato_fries/utils/custom_widget_registry.dart';
import 'package:potato_fries/widgets/custom/accent_picker.dart';
import 'package:potato_fries/widgets/custom/icon_pack_picker.dart';
import 'package:potato_fries/widgets/custom/icon_shape_picker.dart';
import 'package:potato_fries/widgets/custom/lock_screen_clock_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  CustomWidgetRegistry.register(CustomWidget(
    AccentPicker(),
    {
      SettingKey<String>(
        'accent_dark',
        SettingType.SECURE,
      ): Colors.lightBlueAccent.value,
      SettingKey<String>(
        'accent_light',
        SettingType.SECURE,
      ): Colors.blueAccent.value,
    },
  ));
  CustomWidgetRegistry.register(CustomWidget(
    IconPackPicker(),
    {
      SettingKey<String>(
        'theme_customization_overlay_packages',
        SettingType.SECURE,
      ): "{}",
    },
  ));
  CustomWidgetRegistry.register(CustomWidget(
    IconShapePicker(),
    {
      SettingKey<String>(
        'theme_customization_overlay_packages',
        SettingType.SECURE,
      ): "{}",
    },
  ));
  CustomWidgetRegistry.register(CustomWidget(
    LockScreenClockPicker(),
    {
      SettingKey<String>(
        "lock_screen_custom_clock_face",
        SettingType.SECURE,
      ): 'com.android.keyguard.clock.DefaultClockController',
    },
  ));

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
        final provider = context.watch<PageProvider>();
        final accentLight = Color(provider.accentLight).withOpacity(1);
        final accentDark = Color(provider.accentDark).withOpacity(1);
        final themes = Themes(accentLight, accentDark);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fries',
          theme: themes.light,
          darkTheme: themes.dark,
          home: FriesHome(),
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
              systemNavigationBarColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
              systemNavigationBarIconBrightness:
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
            ));

            return child;
          },
        );
      },
    );
  }
}
