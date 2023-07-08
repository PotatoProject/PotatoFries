import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potato_fries/backend/appinfo.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/ui/themes/slider.dart';

final class FriesTheme {
  const FriesTheme._();

  static ThemeData light({required MonetColors colors}) {
    return _buildMaterialTheme(
      _colorsFromMonet(colors, Brightness.light),
    );
  }

  static ThemeData dark({required MonetColors colors}) {
    return _buildMaterialTheme(
      _colorsFromMonet(colors, Brightness.dark),
    );
  }

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

  static ThemeData _buildMaterialTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      appBarTheme: AppBarTheme(
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
        thumbShape: const FriesSliderThumbShape(),
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
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24),
          ),
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
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(0, 40)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12),
          ),
          overlayColor: MaterialStateProperty.all(
            colorScheme.primary.withOpacity(0.1),
          ),
          elevation: MaterialStateProperty.all(0),
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
            Radius.circular(16),
          ),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.scaled,
          ),
        },
      ),
    );
  }
}
