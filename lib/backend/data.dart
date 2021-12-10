// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/pages.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';
import 'package:potato_fries/ui/components/headers/theme.dart';

class Settings {
  const Settings._();

  static const Setting<double> monet_engine_chroma_factor = Setting<double>(
    "monet_engine_chroma_factor",
    SettingTable.secure,
    1.0,
  );

  static const Setting<bool> monet_engine_linear_lightness = Setting<bool>(
    "monet_engine_linear_lightness",
    SettingTable.secure,
    false,
  );

  static const Setting<int> monet_engine_white_luminance_user = Setting<int>(
    "monet_engine_white_luminance_user",
    SettingTable.secure,
    425,
  );

  static const Setting<bool> monet_engine_accurate_shades = Setting<bool>(
    "monet_engine_accurate_shades",
    SettingTable.secure,
    true,
  );

  static const Setting<bool> monet_engine_custom_color = Setting<bool>(
    "monet_engine_custom_color",
    SettingTable.secure,
    false,
  );

  static const Setting<int> monet_engine_color_override = Setting<int>(
    "monet_engine_color_override",
    SettingTable.secure,
    2201331, // #2196f3, default material blue
  );
}

class Properties {
  const Properties._();

  static const PropertyKey ro_potato_vernum = PropertyKey("ro.potato.vernum");
  static const PropertyKey ro_potato_device = PropertyKey("ro.potato.device");
  static const PropertyKey ro_product_model = PropertyKey("ro.product.model");
  static const PropertyKey ro_potato_version = PropertyKey("ro.potato.version");
  static const PropertyKey ro_potato_dish = PropertyKey("ro.potato.dish");

  static const List<PropertyKey> internallyUsedProperties = [
    ro_potato_vernum,
    ro_potato_device,
    ro_product_model,
    ro_potato_version,
    ro_potato_dish,
  ];
}

class Pages {
  const Pages._();

  static const FriesPage qs = FriesPage(
    title: "QS",
    icon: Icons.brightness_6_outlined,
    selectedIcon: Icons.brightness_6,
    sections: [
      PageSection(
        title: 'First',
        preferences: [],
      ),
    ],
  );

  static const FriesPage system = FriesPage(
    title: "System",
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    sections: [],
  );

  static const FriesPage themes = FriesPage(
    title: "Themes",
    icon: Icons.color_lens_outlined,
    selectedIcon: Icons.color_lens,
    header: ThemeHeader(),
    sections: [
      PageSection(
        title: "Colors",
        preferences: [
          SliderSettingPreference<double>(
            setting: Settings.monet_engine_chroma_factor,
            title: "Colorfulness",
            description: "Define how colorful the generated colors should be",
            icon: Icons.palette,
            min: 0.5,
            max: 2.0,
          ),
          SwitchSettingPreference(
            setting: Settings.monet_engine_linear_lightness,
            title: "Use custom lightness scale",
            description:
                "If enables it allows using the custom lightness scale",
          ),
          SliderSettingPreference<int>(
            setting: Settings.monet_engine_white_luminance_user,
            title: "Lightness",
            description: "Decides how bright the colors should be",
            icon: Icons.brightness_5,
            min: 0,
            max: 1000,
            dependencies: [
              SettingDependency(Settings.monet_engine_linear_lightness, true),
            ],
          ),
          SwitchSettingPreference(
            setting: Settings.monet_engine_accurate_shades,
            title: "Generate accurate shades",
            icon: Icons.format_paint,
          ),
          SwitchSettingPreference(
            setting: Settings.monet_engine_custom_color,
            title: "Use custom color",
            description: "Use a custom color for the monet engine",
          ),
          ColorSettingPreference.asRgb(
            setting: Settings.monet_engine_color_override,
            title: "Color override",
            description: "The custom color to use for the engine",
            icon: Icons.colorize,
            dependencies: [
              SettingDependency(Settings.monet_engine_custom_color, true),
            ],
          ),
        ],
      ),
    ],
  );

  static const FriesPage statusbar = FriesPage(
    title: "Statusbar",
    icon: Icons.signal_cellular_0_bar,
    selectedIcon: Icons.signal_cellular_4_bar,
    sections: [],
  );

  static const FriesPage keyguard = FriesPage(
    title: "Keyguard",
    icon: Icons.lock_outlined,
    selectedIcon: Icons.lock,
    sections: [],
  );

  static const List<FriesPage> list = [
    qs,
    system,
    themes,
    statusbar,
    keyguard,
  ];

  static Future<void> registerAndSubscribe(
    SettingSink sink,
    PropertyRegister register,
  ) async {
    final List<Preference> preferences =
        list.expand((page) => page.preferences).toList();
    final List<Preference> subPreferences = preferences
        .whereType<SubpagePreference>()
        .expand((e) => e.subpage.preferences)
        .toList();
    preferences.addAll(subPreferences);

    final List<ScrapeInfo> scrapeInfoList =
        list.map((e) => e.scrape()).toList();
    final ScrapeInfo scrapeInfo = ScrapeInfo(
      scrapeInfoList.expand((e) => e.settings).toList(),
      scrapeInfoList.expand((e) => e.properties).toList(),
    );

    final Set<Setting> settings = scrapeInfo.settings.toSet();
    final Set<PropertyKey> properties = scrapeInfo.properties.toSet();

    // Those properties don't get used anywhere inside pages but are used
    // in the app itself, so we need to add those manually
    properties.addAll(Properties.internallyUsedProperties);

    await _subscribeSettings(sink, settings.toList());
    await _registerProperties(register, properties.toList());
  }

  static Future<void> _subscribeSettings(
    SettingSink sink,
    List<Setting> settings,
  ) async {
    Future<void> _subscribeType<T>() async {
      final Iterable<Setting<T>> _typeSettings =
          settings.whereType<Setting<T>>();

      for (final Setting<T> setting in _typeSettings) {
        await sink.subscribe<T>(setting);
      }
    }

    await _subscribeType<int>();
    await _subscribeType<String>();
    await _subscribeType<bool>();
    await _subscribeType<double>();
  }

  static Future<void> _registerProperties(
    PropertyRegister register,
    List<PropertyKey> properties,
  ) async {
    for (final PropertyKey prop in properties) {
      await register.register(prop);
    }
  }
}
