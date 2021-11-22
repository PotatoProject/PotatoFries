import 'package:flutter/material.dart';
import 'package:monet/monet.dart';

class M3ColorScheme extends ColorScheme {
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color tertiary;
  final Color tertiaryContainer;
  final Color surfaceVariant;
  final Color errorContainer;
  final Color onPrimaryContainer;
  final Color onSecondaryContainer;
  final Color onTertiary;
  final Color onTertiaryContainer;
  final Color onSurfaceVariant;
  final Color onErrorContainer;
  final Color outline;
  final Color shadow;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;

  const M3ColorScheme({
    required Color primary,
    required this.primaryContainer,
    required Color secondary,
    required this.secondaryContainer,
    required this.tertiary,
    required this.tertiaryContainer,
    required Color surface,
    required this.surfaceVariant,
    required Color background,
    required Color error,
    required this.errorContainer,
    required Color onPrimary,
    required this.onPrimaryContainer,
    required Color onSecondary,
    required this.onSecondaryContainer,
    required this.onTertiary,
    required this.onTertiaryContainer,
    required Color onSurface,
    required this.onSurfaceVariant,
    required Color onBackground,
    required Color onError,
    required this.onErrorContainer,
    required this.outline,
    required this.shadow,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required Brightness brightness,
  }) : super(
          primary: primary,
          primaryVariant: primary,
          secondary: secondary,
          secondaryVariant: secondary,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightness,
        );

  factory M3ColorScheme.fromMonetColors(
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

    final M3ColorScheme result = M3ColorScheme(
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

  @override
  M3ColorScheme copyWith({
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? outline,
    Color? shadow,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    @Deprecated('Use primary or primaryContainer instead. '
        'This feature was deprecated after v2.6.0-0.0.pre.')
        Color? primaryVariant,
    @Deprecated('Use secondary or secondaryContainer instead. '
        'This feature was deprecated after v2.6.0-0.0.pre.')
        Color? secondaryVariant,
  }) {
    return M3ColorScheme(
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      shadow: shadow ?? this.shadow,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
    );
  }

  static M3ColorScheme lerp(M3ColorScheme a, M3ColorScheme b, double t) {
    return M3ColorScheme(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      primary: Color.lerp(a.primary, b.primary, t)!,
      onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(a.onPrimaryContainer, b.onPrimaryContainer, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
      secondaryContainer:
          Color.lerp(a.secondaryContainer, b.secondaryContainer, t)!,
      onSecondaryContainer:
          Color.lerp(a.onSecondaryContainer, b.onSecondaryContainer, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      onTertiary: Color.lerp(a.onTertiary, b.onTertiary, t)!,
      tertiaryContainer:
          Color.lerp(a.tertiaryContainer, b.tertiaryContainer, t)!,
      onTertiaryContainer:
          Color.lerp(a.onTertiaryContainer, b.onTertiaryContainer, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      onError: Color.lerp(a.onError, b.onError, t)!,
      errorContainer: Color.lerp(a.errorContainer, b.errorContainer, t)!,
      onErrorContainer: Color.lerp(a.onErrorContainer, b.onErrorContainer, t)!,
      background: Color.lerp(a.background, b.background, t)!,
      onBackground: Color.lerp(a.onBackground, b.onBackground, t)!,
      surface: Color.lerp(a.surface, b.surface, t)!,
      onSurface: Color.lerp(a.onSurface, b.onSurface, t)!,
      surfaceVariant: Color.lerp(a.surfaceVariant, b.surfaceVariant, t)!,
      onSurfaceVariant: Color.lerp(a.onSurfaceVariant, b.onSurfaceVariant, t)!,
      outline: Color.lerp(a.outline, b.outline, t)!,
      shadow: Color.lerp(a.shadow, b.shadow, t)!,
      inverseSurface: Color.lerp(a.inverseSurface, b.inverseSurface, t)!,
      onInverseSurface: Color.lerp(a.onInverseSurface, b.onInverseSurface, t)!,
      inversePrimary: Color.lerp(a.inversePrimary, b.inversePrimary, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is M3ColorScheme &&
        other.brightness == brightness &&
        other.primary == primary &&
        other.onPrimary == onPrimary &&
        other.primaryContainer == primaryContainer &&
        other.onPrimaryContainer == onPrimaryContainer &&
        other.secondary == secondary &&
        other.onSecondary == onSecondary &&
        other.secondaryContainer == secondaryContainer &&
        other.onSecondaryContainer == onSecondaryContainer &&
        other.tertiary == tertiary &&
        other.onTertiary == onTertiary &&
        other.tertiaryContainer == tertiaryContainer &&
        other.onTertiaryContainer == onTertiaryContainer &&
        other.error == error &&
        other.onError == onError &&
        other.errorContainer == errorContainer &&
        other.onErrorContainer == onErrorContainer &&
        other.background == background &&
        other.onBackground == onBackground &&
        other.surface == surface &&
        other.onSurface == onSurface &&
        other.surfaceVariant == surfaceVariant &&
        other.onSurfaceVariant == onSurfaceVariant &&
        other.outline == outline &&
        other.shadow == shadow &&
        other.inverseSurface == inverseSurface &&
        other.onInverseSurface == onInverseSurface &&
        other.inversePrimary == inversePrimary &&
        other.primaryVariant == primaryVariant &&
        other.secondaryVariant == secondaryVariant;
  }

  @override
  int get hashCode {
    return hashList(<Object?>[
      brightness,
      primary,
      onPrimary,
      primaryContainer,
      onPrimaryContainer,
      secondary,
      onSecondary,
      secondaryContainer,
      onSecondaryContainer,
      tertiary,
      onTertiary,
      tertiaryContainer,
      onTertiaryContainer,
      error,
      onError,
      errorContainer,
      onErrorContainer,
      background,
      onBackground,
      surface,
      onSurface,
      surfaceVariant,
      onSurfaceVariant,
      outline,
      shadow,
      inverseSurface,
      onInverseSurface,
      inversePrimary,
      primaryVariant,
      secondaryVariant,
    ]);
  }
}
