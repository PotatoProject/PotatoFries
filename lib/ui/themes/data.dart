import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/ui/themes/colors.dart';
import 'package:potato_fries/ui/themes/slider.dart';
import 'package:potato_fries/ui/themes/text.dart';

class FriesThemeData {
  static const M3TextTheme _baseTextTheme = M3TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      height: 64 / 57, // 64
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      height: 52 / 45, // 52
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      height: 44 / 36, // 44
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      height: 40 / 32, // 40
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      height: 36 / 28, // 36
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      height: 32 / 24, // 32
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      height: 28 / 22, // 28
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 24 / 16, // 24
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 20 / 14, // 20
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16, // 24
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 20 / 14, // 20
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      height: 16 / 12, // 16
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 20 / 14, // 20
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 16 / 12, // 16
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 16 / 11, // 16
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );

  static final M3TextTheme _whiteTextTheme =
      _baseTextTheme.apply(displayColor: Colors.white);
  static final M3TextTheme _blackTextTheme =
      _baseTextTheme.apply(displayColor: Colors.black);

  final M3ColorScheme colorScheme;
  final M3TextTheme textTheme;

  const FriesThemeData({
    required this.colorScheme,
    required this.textTheme,
  });

  FriesThemeData.light({required MonetColors colors})
      : this(
          colorScheme: M3ColorScheme.fromMonetColors(
            colors,
            Brightness.light,
          ),
          textTheme: _blackTextTheme,
        );

  FriesThemeData.dark({required MonetColors colors})
      : this(
          colorScheme: M3ColorScheme.fromMonetColors(
            colors,
            Brightness.dark,
          ),
          textTheme: _whiteTextTheme,
        );

  factory FriesThemeData.lerp(
    FriesThemeData a,
    FriesThemeData b,
    double t,
  ) {
    return FriesThemeData(
      textTheme: M3TextTheme.lerp(a.textTheme, b.textTheme, t),
      colorScheme: M3ColorScheme.lerp(a.colorScheme, b.colorScheme, t),
    );
  }

  ThemeData get materialTheme {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.background,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.secondaryContainer,
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? colorScheme.onSecondaryContainer
                : colorScheme.onSurfaceVariant,
            size: 24,
          ),
        ),
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => textTheme.labelMedium!.copyWith(
            color: states.contains(MaterialState.selected)
                ? colorScheme.onSurface
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: 64,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurfaceVariant,
        titleTextStyle: textTheme.titleLarge!.copyWith(
          color: colorScheme.onBackground,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: colorScheme.brightness.inverted,
          statusBarIconBrightness: colorScheme.brightness.inverted,
          systemNavigationBarIconBrightness: colorScheme.brightness.inverted,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
          systemStatusBarContrastEnforced: false,
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 16,
        thumbShape: const FriesSliderThumbShape(thumbRadius: 6),
        trackShape: const FriesSliderTrackShape(),
        overlayShape: const FriesSliderOverlayShape(),
        thumbColor: colorScheme.onPrimary,
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withOpacity(0.38),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? colorScheme.onPrimary
              : colorScheme.surfaceVariant,
        ),
        trackColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected)
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
    );
  }
}

class FriesThemeDataTween extends Tween<FriesThemeData> {
  FriesThemeDataTween({FriesThemeData? begin, FriesThemeData? end})
      : super(begin: begin, end: end);

  @override
  FriesThemeData lerp(double t) => FriesThemeData.lerp(begin!, end!, t);
}
