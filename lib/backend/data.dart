// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/dependency.dart';
import 'package:potato_fries/backend/models/pages.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';

class Settings {
  const Settings._();

  static const Setting<bool> airplane_mode_on =
      Setting<bool>("airplane_mode_on", SettingTable.global, false);

  static const Setting<int> screen_brightness =
      Setting<int>("screen_brightness", SettingTable.system, 0);

  static const Setting<int> logger_buffer_size =
      Setting<int>("logger_buffer_size", SettingTable.secure, 0);

  static const List<Setting> all = [
    airplane_mode_on,
    screen_brightness,
    logger_buffer_size,
  ];
}

class Properties {
  const Properties._();

  static const PropertyKey ro_potato_has_cutout =
      PropertyKey("ro.potato.has_cutout");
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
            description: "amogus",
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
    sections: [],
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
}
