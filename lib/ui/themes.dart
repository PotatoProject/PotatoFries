import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/ui/custom_track_shape.dart';

class Themes {
  final Color accentLight;
  final Color accentDark;

  Themes(this.accentLight, this.accentDark);

  static const Color mainLightColor = Colors.white;
  static const Color mainDarkColor = Colors.black;

  ThemeData get light => ThemeData.light().copyWith(
        accentColor: accentLight,
        sliderTheme: _sliderTheme(accentLight),
        primaryColor: accentLight,
        toggleableActiveColor: accentLight,
        scaffoldBackgroundColor: mainLightColor,
        canvasColor: mainLightColor,
        textButtonTheme: _textButtonTheme(accentLight),
        elevatedButtonTheme: _elevatedButtonTheme(accentLight, Colors.white),
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
        dividerColor: Colors.black12,
        pageTransitionsTheme: _pageTransitionsTheme(),
        textSelectionTheme: _textSelectionTheme(accentLight),
        dialogTheme: DialogTheme(
          backgroundColor: mainLightColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      );

  ThemeData get dark => ThemeData.dark().copyWith(
        accentColor: accentDark,
        sliderTheme: _sliderTheme(accentDark),
        primaryColor: accentDark,
        toggleableActiveColor: accentDark,
        scaffoldBackgroundColor: mainDarkColor,
        canvasColor: mainDarkColor,
        textButtonTheme: _textButtonTheme(accentDark),
        elevatedButtonTheme: _elevatedButtonTheme(accentDark, Colors.black),
        iconTheme: IconThemeData(color: Colors.white.withOpacity(0.7)),
        dividerColor: Colors.white.withOpacity(0.2),
        pageTransitionsTheme: _pageTransitionsTheme(),
        textSelectionTheme: _textSelectionTheme(accentDark),
        dialogTheme: DialogTheme(
          backgroundColor: Color(0xFF212121),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: Color(0xFF212121),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      );

  SliderThemeData _sliderTheme(Color accent) {
    return SliderThemeData(
      trackShape: CustomTrackShape(),
      activeTrackColor: accent,
      inactiveTrackColor: accent.withOpacity(0.25),
      inactiveTickMarkColor: accent,
      thumbColor: accent,
      overlayColor: accent.withOpacity(0.3),
    );
  }

  TextButtonThemeData _textButtonTheme(Color accent) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(accent),
        overlayColor: MaterialStateProperty.all(
          accent.withOpacity(0.25),
        ),
      ),
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme(Color accent, Color text) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(text),
        overlayColor: MaterialStateProperty.all(
          text.withOpacity(0.25),
        ),
        backgroundColor: MaterialStateProperty.all(accent),
        minimumSize: MaterialStateProperty.all(Size(80, 36)),
      ),
    );
  }

  PageTransitionsTheme _pageTransitionsTheme() {
    return PageTransitionsTheme(builders: {
      TargetPlatform.android: SharedAxisPageTransitionsBuilder(
        transitionType: SharedAxisTransitionType.scaled,
      ),
    });
  }

  TextSelectionThemeData _textSelectionTheme(Color accent) {
    return TextSelectionThemeData(
      cursorColor: accent,
      selectionColor: accent.withOpacity(0.4),
      selectionHandleColor: accent,
    );
  }
}
