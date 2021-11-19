import 'dart:ui';

class Locales {
  Locales._();

  static List<Locale> get supported => [
    Locale("en", "US"),
  ];

  static Map<String, Map<String, String>> get data => {
    _$LocaleEnUS().locale: _$LocaleEnUS().data,
  };
}

abstract class _$LocaleBase {
  String locale;
  Map<String, String> data;
}

class _$LocaleEnUS extends _$LocaleBase {
  @override
  String get locale => "en-US";

  @override
  Map<String, String> get data => {
    "audiofx.title": "AudioFX",
    "audiofx.status.on": "On",
    "audiofx.status.off": "Off",
    "audiofx.audio_preset.title": "Audio preset",
    "audiofx.headset_profile.title": "Headset profile",
    "audiofx.headset_profile.default": "Default mode",
    "lockscreen.title": "Lockscreen",
    "lockscreen.clocks.title": "Clocks",
    "lockscreen.clocks.lock_screen_clock.title": "Lock Screen Clock",
    "lockscreen.clocks.lock_screen_clock.v_default": "Default",
    "lockscreen.clocks.lock_screen_clock.v_bubble": "Bubble",
    "lockscreen.clocks.lock_screen_clock.v_analog": "Analog",
    "lockscreen.clocks.lock_screen_clock.v_type": "Type",
    "lockscreen.clocks.lock_screen_clock.v_bold": "Bold",
    "lockscreen.clocks.lock_screen_clock.v_sammy": "Sammy",
    "lockscreen.clocks.lock_screen_clock.v_sammybold": "Sammy bold",
    "lockscreen.clocks.lock_screen_clock.v_sfuny": "SFUNY",
    "preferences.colorpicker.light_error": "Color is too light",
    "preferences.colorpicker.dark_error": "Color is too dark",
    "preferences.colorpicker.light_warning": "Color is too light, it may be normalized!",
    "preferences.colorpicker.dark_warning": "Color is too dark, it may be normalized!",
    "qs.title": "Quick Settings",
    "qs.header.no_notifications": "No notifications",
    "statusbar.title": "Statusbar",
    "system.title": "System & Gestures",
    "themes.title": "Themes",
    "themes.header.search_settings": "Search settings",
    "themes.themes.title": "Themes",
    "themes.themes.system_accent.title": "Accent color",
    "themes.themes.system_accent.desc": "Pick your favourite color!",
    "themes.themes.system_accent.cancel": "Cancel",
    "themes.themes.system_accent.confirm": "Confirm",
    "themes.themes.system_accent.light_color.title": "Light",
    "themes.themes.system_accent.light_color.light_warning": "Light color is too light",
    "themes.themes.system_accent.light_color.dark_warning": "Light color is too dark",
    "themes.themes.system_accent.dark_color.title": "Dark",
    "themes.themes.system_accent.dark_color.light_warning": "Dark color is too light",
    "themes.themes.system_accent.dark_color.dark_warning": "Dark color is too dark",
    "themes.themes.system_accent.calculate_shades_label": "Auto-magically calculate alt shades",
    "themes.themes.system_icon_shape.title": "Icon shape",
    "themes.themes.system_icon_pack.title": "System icon pack",
    "themes.themes.sysui_colors_active.title": "Colored SystemUI",
    "themes.themes.sysui_colors_active.desc": "Wallpaper colored scrims and QS",
  };
}

