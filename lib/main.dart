import 'package:flutter/material.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/scroll_behavior.dart';
import 'package:potato_fries/app_native/resources.dart';
import 'package:provider/provider.dart';
import 'package:spicy_components/spicy_components.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FriesRoot());
}

class FriesRoot extends StatelessWidget {
  final AppInfoProvider provider = AppInfoProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Builder(builder: (context) {
        var appInfoProvider = Provider.of<AppInfoProvider>(context);
        return MaterialApp(
          builder: (context, child) => ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: child,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Fries',
          theme: SpicyThemes.light(appInfoProvider.accentDark).copyWith(
            canvasColor: SpicyThemes.light(appInfoProvider.accentLight)
                .scaffoldBackgroundColor,
          ),
          darkTheme: SpicyThemes.dark(appInfoProvider.accentLight).copyWith(
            backgroundColor: appInfoProvider.background,
            canvasColor: appInfoProvider.background,
            bottomSheetTheme: BottomSheetThemeData(
              modalBackgroundColor: appInfoProvider.background,
              shape: RoundedRectangleBorder(),
            ),
            colorScheme: ColorScheme.dark(
              surface: appInfoProvider.background,
              primary: appInfoProvider.accentDark,
              onPrimary: appInfoProvider.background,
            ),
            cardColor: appInfoProvider.background,
            scaffoldBackgroundColor: appInfoProvider.background,
            dialogBackgroundColor: appInfoProvider.background,
            bottomAppBarColor: appInfoProvider.background,
          ),
          home: FriesHome(),
        );
      }),
    );
  }
}
