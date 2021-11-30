// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/pages.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';
import 'package:potato_fries/backend/properties.dart';
import 'package:potato_fries/backend/settings.dart';

class Settings {
  const Settings._();

  static const Setting<bool> airplane_mode_on = Setting<bool>(
    "airplane_mode_on",
    SettingTable.global,
    false,
  );

  static const Setting<int> screen_brightness = Setting<int>(
    "screen_brightness",
    SettingTable.system,
    0,
  );

  static const Setting<int> logger_buffer_size = Setting<int>(
    "logger_buffer_size",
    SettingTable.secure,
    0,
  );

  static const Setting<String> monet_engine_color_override = Setting<String>(
    "monet_engine_color_override",
    SettingTable.secure,
    "#2196f3",
  );
}

class Properties {
  const Properties._();

  static const PropertyKey ro_potato_has_cutout =
      PropertyKey("ro.potato.has_cutout");

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
        preferences: [
          SwitchSettingPreference(
            setting: Settings.airplane_mode_on,
            icon: Icons.airplanemode_active,
            title: "Airplane mode",
          ),
          SliderSettingPreference<int>(
            setting: Settings.screen_brightness,
            icon: Icons.brightness_medium,
            title: "Brightness",
            min: 0,
            max: 255,
            dependencies: [
              SettingDependency(Settings.airplane_mode_on, true),
              PropertyDependency(Properties.ro_potato_has_cutout, null),
            ],
          ),
          DropdownSettingPreference<int>(
            setting: Settings.logger_buffer_size,
            title: "Logger buffer sizes",
            options: {
              0: "Off",
              1: "64K",
              2: "256K",
              3: "1M",
              4: "4M",
              5: "8M",
            },
          ),
          SubpagePreference(
            subpage: FriesSubpage(
              title: "Amoghis",
              preferences: [
                SwitchSettingPreference(
                  setting: Settings.airplane_mode_on,
                  icon: Icons.airplanemode_active,
                  title: "Airplane mode",
                ),
                SliderSettingPreference<int>(
                  setting: Settings.screen_brightness,
                  icon: Icons.brightness_medium,
                  title: "Brightness",
                  min: 0,
                  max: 255,
                  dependencies: [
                    SettingDependency(Settings.airplane_mode_on, true),
                    PropertyDependency(Properties.ro_potato_has_cutout, null),
                  ],
                ),
                DropdownSettingPreference<int>(
                  setting: Settings.logger_buffer_size,
                  title: "Logger buffer sizes",
                  options: {
                    0: "Off",
                    1: "64K",
                    2: "256K",
                    3: "1M",
                    4: "4M",
                    5: "8M",
                  },
                ),
              ],
            ),
            title: "Subpage test",
            description: "dfds",
            icon: Icons.brightness_medium,
          ),
        ],
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
    sections: [
      PageSection(
        title: "Colors",
        preferences: [
          ColorSettingPreference(
            setting: Settings.monet_engine_color_override,
            title: "Monet color override",
            description: "Use a custom color for the monet engine",
            icon: Icons.colorize,
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
