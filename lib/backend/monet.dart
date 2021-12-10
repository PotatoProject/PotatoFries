part of 'appinfo.dart';

class MonetUtils {
  const MonetUtils._();

  static Future<MonetColors> getMonetColors() async {
    return _transformListToColors((await _getPlatformMonetColors())!);
  }

  static Future<List<int>?> _getPlatformMonetColors() {
    return _utilsChannel.invokeMethod<List<int>>("getMonetColors");
  }

  static MonetColors _transformListToColors(List<int> colors) {
    final MonetPalette accent1 = _getPalette(colors, 0);
    final MonetPalette accent2 = _getPalette(colors, 1);
    final MonetPalette accent3 = _getPalette(colors, 2);
    final MonetPalette neutral1 = _getPalette(colors, 3);
    final MonetPalette neutral2 = _getPalette(colors, 4);

    return MonetColors(
      accent1: accent1,
      accent2: accent2,
      accent3: accent3,
      neutral1: neutral1,
      neutral2: neutral2,
    );
  }

  static MonetPalette _getPalette(List<int> colors, int offset) {
    offset *= 13;
    final List<int> subColors = colors.sublist(offset, offset + 13);

    Color _colorAt(int index) => Color(subColors[index]).withOpacity(1);

    return MonetPalette({
      0: _colorAt(0),
      10: _colorAt(1),
      50: _colorAt(2),
      100: _colorAt(3),
      200: _colorAt(4),
      300: _colorAt(5),
      400: _colorAt(6),
      500: _colorAt(7),
      600: _colorAt(8),
      700: _colorAt(9),
      800: _colorAt(10),
      900: _colorAt(11),
      1000: _colorAt(12),
    });
  }
}

/// Represents a collection of [MonetPalette]s that are generated using the bundled in monet engine
///
/// Each [MonetPalette] contains a set of 13 shades of a base color.
/// The base color used for each palette depend on the engine itself.
class MonetColors {
  /// Main accent color. Generally, this is close to the primary color.
  final MonetPalette accent1;

  /// Secondary accent color. Darker shades of [accent1].
  final MonetPalette accent2;

  /// Tertiary accent color. Primary color shifted to the next secondary color via hue offset.
  final MonetPalette accent3;

  /// Main background color. Tinted with the primary color.
  final MonetPalette neutral1;

  /// Secondary background color. Slightly tinted with the primary color.
  final MonetPalette neutral2;

  /// Creates a new instance of [MonetColors].
  ///
  /// Usually there should be no need to call this manually as you can get
  /// an already instanced object by creating a new [MonetProvider] with [MonetProvider.newInstance()]
  /// and then calling [MonetProvider.colors].
  const MonetColors({
    required this.accent1,
    required this.accent2,
    required this.accent3,
    required this.neutral1,
    required this.neutral2,
  });
}

/// A set of 13 shades of a base color that was derived from the monet engine color calculations.
class MonetPalette extends ColorSwatch<int> {
  /// The raw map contains a set of key/values with all the shades
  final Map<int, Color> colors;

  /// Creates a new [MonetPalette]. It's not recommended to use this constructor directly
  /// as working and ready instances are already provided by [MonetColors].
  MonetPalette(this.colors)
      : assert(colors.length == 13),
        super(colors[500]!.value, colors);

  /// Lightest shade of the palette, equals to white.
  Color get shade0 => this[0]!;

  /// Base color at 99% lightness.
  Color get shade10 => this[10]!;

  /// Base color at 95% lightness.
  Color get shade50 => this[50]!;

  /// Base color at 90% lightness.
  Color get shade100 => this[100]!;

  /// Base color at 80% lightness.
  Color get shade200 => this[200]!;

  /// Base color at 70% lightness.
  Color get shade300 => this[300]!;

  /// Base color at 60% lightness.
  Color get shade400 => this[400]!;

  /// Base color at 50% lightness.
  Color get shade500 => this[500]!;

  /// Base color at 40% lightness.
  Color get shade600 => this[600]!;

  /// Base color at 30% lightness.
  Color get shade700 => this[700]!;

  /// Base color at 20% lightness.
  Color get shade800 => this[800]!;

  /// Base color at 10% lightness.
  Color get shade900 => this[900]!;

  /// Darkest shade of the palette, equals: black.
  Color get shade1000 => this[1000]!;

  /// Create a [MaterialColor] out of this palette.
  ///
  /// Note: [shade0], [shade10] and [shade1000] get discarded as they are
  /// not supported in a [MaterialColor].
  MaterialColor get asMaterialColor {
    return MaterialColor(shade500.value, colors);
  }
}
