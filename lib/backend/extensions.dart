import 'package:flutter/material.dart';
import 'package:potato_fries/ui/theme.dart';

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  FriesThemeData get friesTheme => FriesTheme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension BrightnessX on Brightness {
  Brightness get inverted {
    switch (this) {
      case Brightness.dark:
        return Brightness.light;
      case Brightness.light:
        return Brightness.dark;
    }
  }
}
