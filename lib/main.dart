import 'package:flutter/material.dart';
import 'package:potato_fries/pages/home.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/scroll_behavior.dart';
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
        Color background = Color(appInfoProvider.background);
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
            backgroundColor: background,
            canvasColor: background,
            bottomSheetTheme: BottomSheetThemeData(
              modalBackgroundColor: background,
              shape: RoundedRectangleBorder(),
            ),
            colorScheme: ColorScheme.dark(
              surface: background,
              primary: appInfoProvider.accentDark,
              onPrimary: background,
            ),
            cardColor: background,
            scaffoldBackgroundColor: background,
            dialogBackgroundColor: background,
            bottomAppBarColor: background,
          ),
          home: FriesHome(),
        );
      }),
    );
  }
}
