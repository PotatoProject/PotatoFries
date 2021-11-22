import 'package:flutter/material.dart';

class M3TextTheme extends TextTheme {
  const M3TextTheme({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    this.headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    this.labelMedium,
    TextStyle? labelSmall,
  }) : super(
          headline1: displayLarge,
          headline2: displayMedium,
          headline3: displaySmall,
          headline4: headlineMedium,
          headline5: headlineSmall,
          headline6: titleLarge,
          subtitle1: titleMedium,
          subtitle2: titleSmall,
          bodyText1: bodyLarge,
          bodyText2: bodyMedium,
          caption: bodySmall,
          button: labelLarge,
          overline: labelSmall,
        );

  TextStyle? get displayLarge => headline1;
  TextStyle? get displayMedium => headline2;
  TextStyle? get displaySmall => headline3;

  final TextStyle? headlineLarge;
  TextStyle? get headlineMedium => headline4;
  TextStyle? get headlineSmall => headline5;

  TextStyle? get titleLarge => headline6;
  TextStyle? get titleMedium => subtitle1;
  TextStyle? get titleSmall => subtitle2;

  TextStyle? get bodyLarge => bodyText1;
  TextStyle? get bodyMedium => bodyText2;
  TextStyle? get bodySmall => caption;

  TextStyle? get labelLarge => button;
  final TextStyle? labelMedium;
  TextStyle? get labelSmall => overline;

  @override
  M3TextTheme copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    @Deprecated("Don't use, older style.") TextStyle? bodyText1,
    @Deprecated("Don't use, older style.") TextStyle? bodyText2,
    @Deprecated("Don't use, older style.") TextStyle? button,
    @Deprecated("Don't use, older style.") TextStyle? caption,
    @Deprecated("Don't use, older style.") TextStyle? headline1,
    @Deprecated("Don't use, older style.") TextStyle? headline2,
    @Deprecated("Don't use, older style.") TextStyle? headline3,
    @Deprecated("Don't use, older style.") TextStyle? headline4,
    @Deprecated("Don't use, older style.") TextStyle? headline5,
    @Deprecated("Don't use, older style.") TextStyle? headline6,
    @Deprecated("Don't use, older style.") TextStyle? overline,
    @Deprecated("Don't use, older style.") TextStyle? subtitle1,
    @Deprecated("Don't use, older style.") TextStyle? subtitle2,
  }) {
    return M3TextTheme(
      displayLarge: displayLarge ?? headline1 ?? this.displayLarge,
      displayMedium: displayMedium ?? headline2 ?? this.displayMedium,
      displaySmall: displaySmall ?? headline3 ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? headline4 ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? headline5 ?? this.headlineSmall,
      titleLarge: titleLarge ?? headline6 ?? this.titleLarge,
      titleMedium: titleMedium ?? subtitle1 ?? this.titleMedium,
      titleSmall: titleSmall ?? subtitle2 ?? this.titleSmall,
      bodyLarge: bodyLarge ?? bodyText1 ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? bodyText2 ?? this.bodyMedium,
      bodySmall: bodySmall ?? caption ?? this.bodySmall,
      labelLarge: labelLarge ?? button ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? overline ?? this.labelSmall,
    );
  }

  @override
  M3TextTheme merge(
    TextTheme? other, {
    TextStyle? headlineLarge,
    TextStyle? labelMedium,
  }) {
    if (other == null) return this;

    return copyWith(
      displayLarge: displayLarge?.merge(other.headline1) ?? other.headline1,
      displayMedium: displayMedium?.merge(other.headline2) ?? other.headline2,
      displaySmall: displaySmall?.merge(other.headline3) ?? other.headline3,
      headlineLarge: this.headlineLarge?.merge(headlineLarge) ?? headlineLarge,
      headlineMedium: headlineMedium?.merge(other.headline4) ?? other.headline4,
      headlineSmall: headlineSmall?.merge(other.headline5) ?? other.headline5,
      titleLarge: titleLarge?.merge(other.headline6) ?? other.headline6,
      titleMedium: titleMedium?.merge(other.subtitle1) ?? other.subtitle1,
      titleSmall: titleSmall?.merge(other.subtitle2) ?? other.subtitle2,
      bodyLarge: bodyText1?.merge(other.bodyText1) ?? other.bodyText1,
      bodyMedium: bodyText2?.merge(other.bodyText2) ?? other.bodyText2,
      bodySmall: caption?.merge(other.caption) ?? other.caption,
      labelLarge: button?.merge(other.button) ?? other.button,
      labelMedium: this.labelMedium?.merge(labelMedium) ?? labelMedium,
      labelSmall: overline?.merge(other.overline) ?? other.overline,
    );
  }

  @override
  M3TextTheme apply({
    String? fontFamily,
    double fontSizeFactor = 1.0,
    double fontSizeDelta = 0.0,
    Color? displayColor,
    Color? bodyColor,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
  }) {
    return M3TextTheme(
      displayLarge: displayLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      displayMedium: displayMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      displaySmall: displaySmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headlineLarge: headlineLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headlineMedium: headlineMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      headlineSmall: headlineSmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleLarge: titleLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleMedium: titleMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      titleSmall: titleSmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      bodyLarge: bodyLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      bodyMedium: bodyMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      bodySmall: bodySmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      labelLarge: labelLarge?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      labelMedium: labelMedium?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
      labelSmall: labelSmall?.apply(
        color: displayColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        fontFamily: fontFamily,
        fontSizeFactor: fontSizeFactor,
        fontSizeDelta: fontSizeDelta,
      ),
    );
  }

  static M3TextTheme lerp(M3TextTheme? a, M3TextTheme? b, double t) {
    return M3TextTheme(
      displayLarge: TextStyle.lerp(a?.displayLarge, b?.displayLarge, t),
      displayMedium: TextStyle.lerp(a?.displayMedium, b?.displayMedium, t),
      displaySmall: TextStyle.lerp(a?.displaySmall, b?.displaySmall, t),
      headlineLarge: TextStyle.lerp(a?.headlineLarge, b?.headlineLarge, t),
      headlineMedium: TextStyle.lerp(a?.headlineMedium, b?.headlineMedium, t),
      headlineSmall: TextStyle.lerp(a?.headlineSmall, b?.headlineSmall, t),
      titleLarge: TextStyle.lerp(a?.titleLarge, b?.titleLarge, t),
      titleMedium: TextStyle.lerp(a?.titleMedium, b?.titleMedium, t),
      titleSmall: TextStyle.lerp(a?.titleSmall, b?.titleSmall, t),
      bodyLarge: TextStyle.lerp(a?.bodyLarge, b?.bodyLarge, t),
      bodyMedium: TextStyle.lerp(a?.bodyMedium, b?.bodyMedium, t),
      bodySmall: TextStyle.lerp(a?.bodySmall, b?.bodySmall, t),
      labelLarge: TextStyle.lerp(a?.labelLarge, b?.labelLarge, t),
      labelMedium: TextStyle.lerp(a?.labelMedium, b?.labelMedium, t),
      labelSmall: TextStyle.lerp(a?.labelSmall, b?.labelSmall, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;

    return other is M3TextTheme &&
        displayLarge == other.displayLarge &&
        displayMedium == other.displayMedium &&
        displaySmall == other.displaySmall &&
        headlineLarge == other.headlineLarge &&
        headlineMedium == other.headlineMedium &&
        headlineSmall == other.headlineSmall &&
        titleLarge == other.titleLarge &&
        titleMedium == other.titleMedium &&
        titleSmall == other.titleSmall &&
        bodyLarge == other.bodyLarge &&
        bodyMedium == other.bodyMedium &&
        bodySmall == other.bodySmall &&
        labelLarge == other.labelLarge &&
        labelMedium == other.labelMedium &&
        labelSmall == other.labelSmall;
  }

  @override
  int get hashCode {
    // The hashValues() function supports up to 20 arguments.
    return hashValues(
      displayLarge,
      displayMedium,
      displaySmall,
      headlineLarge,
      headlineMedium,
      headlineSmall,
      titleLarge,
      titleMedium,
      titleSmall,
      bodyLarge,
      bodyMedium,
      bodySmall,
      labelLarge,
      labelMedium,
      labelSmall,
    );
  }
}
