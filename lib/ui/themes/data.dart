import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monet/monet.dart';
import 'package:potato_fries/backend/extensions.dart';
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

  final ColorScheme colorScheme;
  final M3TextTheme textTheme;

  const FriesThemeData({
    required this.colorScheme,
    required this.textTheme,
  });

  FriesThemeData.light({required MonetColors colors})
      : this(
          colorScheme: _colorsFromMonet(colors, Brightness.light),
          textTheme: _blackTextTheme,
        );

  FriesThemeData.dark({required MonetColors colors})
      : this(
          colorScheme: _colorsFromMonet(colors, Brightness.dark),
          textTheme: _whiteTextTheme,
        );

  static ColorScheme _colorsFromMonet(
    MonetColors colors,
    Brightness brightness,
  ) {
    /// refer to https://m3.material.io/styles/color/the-color-system/tokens for detailed explanation

    final bool d = brightness == Brightness.dark;

    final MonetPalette primaries = colors.accent1;
    final MonetPalette secondaries = colors.accent2;
    final MonetPalette tertiaries = colors.accent3;
    final MonetPalette neutrals = colors.neutral1;
    final MonetPalette neutralVariants = colors.neutral2;
    final MonetPalette errors = MonetPalette(const {
      0: Color(0xFFFFFFFF),
      10: Color(0xFFFCFCFC),
      50: Color(0xFFFFEDE9),
      100: Color(0xFFFFDAD4),
      200: Color(0xFFFFB4A9),
      300: Color(0xFFFF897A),
      400: Color(0xFFFF5449),
      500: Color(0xFFDD3730),
      600: Color(0xFFBA1B1B),
      700: Color(0xFF930006),
      800: Color(0xFF680003),
      900: Color(0xFF410001),
      1000: Color(0xFF000000),
    });

    final Color primary = primaries[d ? 200 : 600]!;
    final Color primaryContainer = primaries[d ? 700 : 100]!;
    final Color secondary = secondaries[d ? 200 : 600]!;
    final Color secondaryContainer = secondaries[d ? 700 : 100]!;
    final Color tertiary = tertiaries[d ? 200 : 600]!;
    final Color tertiaryContainer = tertiaries[d ? 700 : 100]!;
    final Color error = errors[d ? 200 : 600]!;
    final Color errorContainer = errors[d ? 700 : 100]!;

    final Color background = neutrals[d ? 900 : 10]!;
    final Color surface = background;
    final Color surfaceVariant = neutralVariants[d ? 700 : 100]!;

    final Color onPrimary = primaries[d ? 800 : 0]!;
    final Color onSecondary = secondaries[d ? 800 : 0]!;
    final Color onTertiary = tertiaries[d ? 800 : 0]!;
    final Color onPrimaryContainer = primaries[d ? 100 : 900]!;
    final Color onSecondaryContainer = secondaries[d ? 100 : 900]!;
    final Color onTertiaryContainer = tertiaries[d ? 100 : 900]!;
    final Color onError = errors[d ? 800 : 0]!;
    final Color onErrorContainer = errors[d ? 100 : 900]!;

    final Color onBackground = neutrals[d ? 100 : 900]!;
    final Color onSurface = onBackground;
    final Color onSurfaceVariant = neutralVariants[d ? 200 : 700]!;

    final Color outline = neutralVariants[d ? 400 : 500]!;
    final Color shadow = neutrals.shade1000;

    final Color inverseSurface = neutrals[d ? 100 : 800]!;
    final Color onInverseSurface = neutrals[d ? 800 : 50]!;
    final Color inversePrimary = primaries[d ? 600 : 200]!;

    final ColorScheme result = ColorScheme(
      primary: primary,
      primaryContainer: primaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      tertiary: tertiary,
      tertiaryContainer: tertiaryContainer,
      error: error,
      errorContainer: errorContainer,
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      onPrimary: onPrimary,
      onPrimaryContainer: onPrimaryContainer,
      onSecondary: onSecondary,
      onSecondaryContainer: onSecondaryContainer,
      onTertiary: onTertiary,
      onTertiaryContainer: onTertiaryContainer,
      onBackground: onBackground,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      onError: onError,
      onErrorContainer: onErrorContainer,
      outline: outline,
      shadow: shadow,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      brightness: d ? Brightness.dark : Brightness.light,
    );

    return result;
  }

  factory FriesThemeData.lerp(
    FriesThemeData a,
    FriesThemeData b,
    double t,
  ) {
    return FriesThemeData(
      textTheme: M3TextTheme.lerp(a.textTheme, b.textTheme, t),
      colorScheme: ColorScheme.lerp(a.colorScheme, b.colorScheme, t),
    );
  }

  static Color applyElevation(
    Color background,
    Color foreground,
    int elevation,
  ) {
    assert(elevation > 0 && elevation <= 5);
    final double opacity;

    switch (elevation) {
      case 1:
        opacity = 0.05;
        break;
      case 2:
        opacity = 0.08;
        break;
      case 3:
        opacity = 0.11;
        break;
      case 4:
        opacity = 0.12;
        break;
      case 5:
        opacity = 0.14;
        break;
      default:
        throw Exception("Invalid elevation");
    }

    return Color.alphaBlend(foreground.withOpacity(opacity), background);
  }

  ThemeData get materialTheme {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: FriesThemeData.applyElevation(
          colorScheme.surface,
          colorScheme.primary,
          2,
        ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24),
          ),
          shape: MaterialStateProperty.all(const StadiumBorder()),
          textStyle: MaterialStateProperty.all(textTheme.labelLarge),
          overlayColor: MaterialStateProperty.all(
            colorScheme.onPrimary.withOpacity(0.1),
          ),
          elevation: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ? 1 : 0,
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? colorScheme.onSurface.withOpacity(0.12)
                : colorScheme.primary,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? colorScheme.onSurface.withOpacity(0.38)
                : colorScheme.onPrimary,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24),
          ),
          shape: MaterialStateProperty.all(const StadiumBorder()),
          textStyle: MaterialStateProperty.all(textTheme.labelLarge),
          overlayColor: MaterialStateProperty.all(
            colorScheme.primary.withOpacity(0.1),
          ),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(MaterialState.focused)
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(
                      states.contains(MaterialState.disabled) ? 0.12 : 1.0,
                    ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? colorScheme.onSurface.withOpacity(0.38)
                : colorScheme.primary,
          ),
        ),
      ),
      cardColor: colorScheme.surfaceVariant,
      cardTheme: const CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
      }),
    );
  }
}

class FriesThemeDataTween extends Tween<FriesThemeData> {
  FriesThemeDataTween({FriesThemeData? begin, FriesThemeData? end})
      : super(begin: begin, end: end);

  @override
  FriesThemeData lerp(double t) => FriesThemeData.lerp(begin!, end!, t);
}
