import 'dart:ui';

class Locales {
  Locales._();

  static List<Locale> get supported => [
        Locale("en", "US"),
        Locale("pt", "BR"),
      ];

  static Map<String, Map<String, String>> get data => {
        _$LocaleEnUS().locale: _$LocaleEnUS().data,
        _$LocalePtBR().locale: _$LocalePtBR().data,
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
        "lockscreen.albumart.title": "Album art",
        "lockscreen.albumart.lockscreen_media_metadata.title":
            "Lockscreen media art",
        "lockscreen.albumart.lockscreen_media_metadata.desc":
            "Show album art on lockscreen",
        "lockscreen.albumart.lockscreen_media_blur.title":
            "Lockscreen blur level",
        "lockscreen.albumart.lockscreen_media_blur.desc":
            "Configure blur intensity of lockscreen media art",
        "lockscreen.pocket.title": "Pocket mode",
        "lockscreen.pocket.pocket_judge.title": "Pocket detection",
        "lockscreen.pocket.pocket_judge.desc":
            "Block screen and button inputs when device is in pocket",
        "lockscreen.tuner.title": "Lockscreen shortcuts",
        "lockscreen.tuner.systemui_tuner_lockscreen.title": "Lockscreen tuner",
        "lockscreen.tuner.systemui_tuner_lockscreen.desc":
            "Manage lockscreen shortcuts",
        "preferences.colorpicker.light_error": "Color is too light",
        "preferences.colorpicker.dark_error": "Color is too dark",
        "preferences.colorpicker.light_warning":
            "Color is too light, it may be normalized!",
        "preferences.colorpicker.dark_warning":
            "Color is too dark, it may be normalized!",
        "qs.title": "Quick Settings",
        "qs.header.no_notifications": "No notifications",
        "qs.tweaks.title": "Quick settings tweaks",
        "qs.tweaks.qs_show_auto_brightness.title": "QS Auto brightness",
        "qs.tweaks.qs_show_auto_brightness.desc":
            "Show auto brightness icon on QS panel",
        "qs.tweaks.qs_show_brightness_slider.title": "Brightness slider",
        "qs.tweaks.qs_show_brightness_slider.desc":
            "Show a brightness slider in the quick settings panel",
        "qs.tweaks.qs_show_brightness_slider.v_0": "Never show",
        "qs.tweaks.qs_show_brightness_slider.v_1": "Show when expanded",
        "qs.tweaks.qs_show_brightness_slider.v_2": "Show always",
        "qs.tweaks.qs_tile_title_visibility.title": "Show title of QS tiles",
        "qs.tweaks.qs_tile_title_visibility.desc":
            "Hide or show title of QS tiles",
        "qs.tweaks.qs_rows_portrait.title": "Tiles rows on portrait",
        "qs.tweaks.qs_columns_portrait.title": "Tiles columns on portrait",
        "qs.tweaks.qs_rows_landscape.title": "Tiles rows on landscape",
        "qs.tweaks.qs_columns_landscape.title": "Tiles columns on landscape",
        "qs.colors.title": "Quick settings colors",
        "qs.colors.qs_panel_bg_use_fw.title": "Framework defaults",
        "qs.colors.qs_panel_bg_use_fw.desc":
            "Disable QS and scrim color customizations",
        "qs.colors.qs_panel_bg_color.title": "Background color",
        "qs.colors.qs_panel_bg_color.desc": "Change color of your QS panel",
        "qs.colors.qs_panel_bg_alpha.title": "Background alpha",
        "qs.colors.qs_panel_bg_disco.title": "QS Tile Disco",
        "qs.colors.qs_panel_bg_disco.desc": "Make your QS Tiles colorful!",
        "statusbar.title": "Statusbar",
        "statusbar.cutouts.title": "Display Cutouts",
        "statusbar.cutouts.display_cutout_mode.title": "Cutout mode",
        "statusbar.cutouts.display_cutout_mode.v_0": "Normal",
        "statusbar.cutouts.display_cutout_mode.v_1": "Immerse",
        "statusbar.cutouts.display_cutout_mode.v_2": "Hide",
        "statusbar.cutouts.stock_statusbar_in_hide.title":
            "Stock Statusbar in Hide",
        "statusbar.cutouts.stock_statusbar_in_hide.desc":
            "Use default (usually smaller) statusbar height in hide",
        "statusbar.cutouts.sysui_rounded_size.title": "Rounded corner radius",
        "statusbar.clock.title": "Clock",
        "statusbar.clock.smartclock.title": "Smart Clock",
        "statusbar.clock.smartclock.desc":
            "Show the clock periodically for a brief period",
        "statusbar.icons.title": "StatusBar Icons",
        "statusbar.icons.show_fourg_icon.title": "4G icon",
        "statusbar.icons.show_fourg_icon.desc":
            "Display 4G icon in status bar instead LTE",
        "statusbar.icons.show_volte_icon.title": "VoLTE icon",
        "statusbar.icons.show_volte_icon.desc":
            "Display HD icon in status bar for VoLTE",
        "statusbar.icons.roaming_indicator_icon.title": "Roaming icon",
        "statusbar.icons.roaming_indicator_icon.desc":
            "Display roaming icon in status bar",
        "statusbar.icons.systemui_tuner_statusbar.title":
            "System statusbar icons",
        "statusbar.icons.systemui_tuner_statusbar.desc":
            "Disable/Enable system icons from statusbar",
        "statusbar.nettraffic.title": "Network traffic monitor",
        "statusbar.nettraffic.network_traffic_location.title": "Display mode",
        "statusbar.nettraffic.network_traffic_location.v_0": "Disabled",
        "statusbar.nettraffic.network_traffic_location.v_1": "Status bar",
        "statusbar.nettraffic.network_traffic_location.v_2": "Quick settings",
        "statusbar.nettraffic.network_traffic_autohide.title": "Auto hide",
        "statusbar.nettraffic.network_traffic_autohide.desc":
            "Hide the traffic monitor when there is no activity",
        "statusbar.nettraffic.network_traffic_unit_type.title": "Traffic units",
        "statusbar.nettraffic.network_traffic_unit_type.v_0": "Bytes",
        "statusbar.nettraffic.network_traffic_unit_type.v_1": "Bits",
        "statusbar.battery.title": "Battery",
        "statusbar.battery.status_bar_battery_style.title": "Battery Style",
        "statusbar.battery.status_bar_battery_style.v_0": "Portrait",
        "statusbar.battery.status_bar_battery_style.v_1": "Circle",
        "statusbar.battery.status_bar_battery_style.v_2": "Dotted Circle",
        "statusbar.battery.status_bar_battery_style.v_3": "Solid Circle",
        "statusbar.battery.status_bar_battery_style.v_4": "Text",
        "statusbar.battery.status_bar_battery_style.v_5": "Hidden",
        "statusbar.battery.status_bar_show_battery_percent.title":
            "Battery Percentage",
        "statusbar.battery.status_bar_show_battery_percent.v_0": "Hidden",
        "statusbar.battery.status_bar_show_battery_percent.v_1":
            "Inside the icon",
        "statusbar.battery.status_bar_show_battery_percent.v_2":
            "Next to the icon",
        "statusbar.battery.qs_header_show_battery_percent.title":
            "QS battery percentage",
        "statusbar.battery.qs_header_show_battery_percent.desc":
            "Show battery percentage in the QS header instead of estimate",
        "system.title": "System & Gestures",
        "system.buttons.title": "Buttons",
        "system.buttons.volume_button_music_control.title":
            "Volume buttons to skip tracks",
        "system.buttons.volume_button_music_control.desc":
            "Long press volume buttons to forward/backward track",
        "system.buttons.advanced_reboot.title": "Advanced Reboot",
        "system.buttons.advanced_reboot.desc": "Show extra reboot options",
        "system.gestures.title": "Gestures",
        "system.gestures.double_tap_sleep_lockscreen.title":
            "Double tap to sleep on lockscreen",
        "system.gestures.double_tap_sleep_lockscreen.desc":
            "Turn off screen by double tapping empty space on lockscreen",
        "system.gestures.three_finger_gesture.title": "Three finger screenshot",
        "system.gestures.three_finger_gesture.desc":
            "Swipe down with three fingers to screenshot",
        "system.gestures.pulse_on_new_tracks.title": "Ambient music tracks",
        "system.gestures.pulse_on_new_tracks.desc":
            "Show Ambient Display when a new music track is played",
        "system.navigation.title": "Navigation",
        "system.navigation.sysui_nav_bar_hint.title": "Show gestural pill",
        "system.navigation.sysui_nav_bar_hint.desc":
            "Toggle the navigation handle/pill",
        "system.navigation.navigation_handle_width.title":
            "Navigation handle length",
        "system.navigation.sysui_nav_bar_inverse.title":
            "Swap navigation buttons",
        "system.navigation.sysui_nav_bar_inverse.desc":
            "Swap navigation buttons when using 3 button layout",
        "system.navigation.systemui_tuner_navbar.title": "Navigation bar tuner",
        "system.navigation.systemui_tuner_navbar.desc":
            "Swap navigation bar layout",
        "system.network.title": "Network",
        "system.network.tethering_allow_vpn_upstreams.title":
            "Allow clients to use VPNs",
        "system.network.tethering_allow_vpn_upstreams.desc":
            "Permit hotspot/tethering clients to use this device's VPN connection",
        "system.packagemanager.title": "Package manager",
        "system.packagemanager.allow_signature_fake.title":
            "Package signature spoofing",
        "system.packagemanager.allow_signature_fake.desc":
            "Allow fake signatures (useful for microG)",
        "system.notifications.title": "Notifications",
        "system.notifications.less_boring_heads_up.title":
            "Less boring heads up",
        "system.notifications.less_boring_heads_up.desc":
            "Only receive heads up from calling and messaging apps",
        "themes.title": "Themes",
        "themes.header.search_settings": "Search settings",
        "themes.themes.title": "Themes",
        "themes.themes.system_accent.title": "Accent color",
        "themes.themes.system_accent.desc": "Pick your favourite color!",
        "themes.themes.system_accent.cancel": "Cancel",
        "themes.themes.system_accent.confirm": "Confirm",
        "themes.themes.system_accent.light_color.title": "Light",
        "themes.themes.system_accent.light_color.light_warning":
            "Light color is too light",
        "themes.themes.system_accent.light_color.dark_warning":
            "Light color is too dark",
        "themes.themes.system_accent.dark_color.title": "Dark",
        "themes.themes.system_accent.dark_color.light_warning":
            "Dark color is too light",
        "themes.themes.system_accent.dark_color.dark_warning":
            "Dark color is too dark",
        "themes.themes.system_accent.calculate_shades_label":
            "Auto-magically calculate alt shades",
        "themes.themes.system_icon_shape.title": "Icon shape",
        "themes.themes.system_icon_pack.title": "System icon pack",
        "themes.themes.systemui_plugin_volume.title": "Volume panel",
        "themes.themes.systemui_plugin_volume.v_aosp": "AOSP",
        "themes.themes.systemui_plugin_volume.v_compact": "Compact",
        "themes.themes.systemui_plugin_volume.v_oreo": "Oreo",
        "themes.themes.systemui_plugin_volume.v_tiled": "Tiled",
        "themes.themes.volume_panel_on_left.title": "Volume panel direction",
        "themes.themes.volume_panel_on_left.v_0": "Right",
        "themes.themes.volume_panel_on_left.v_1": "Left",
        "themes.themes.sysui_colors_active.title": "Colored SystemUI",
        "themes.themes.sysui_colors_active.desc":
            "Wallpaper colored scrims and QS",
      };
}

class _$LocalePtBR extends _$LocaleBase {
  @override
  String get locale => "pt-BR";

  @override
  Map<String, String> get data => {
        "qs.title": "Configurações Rápidas",
        "qs.header.no_notifications": "Sem notificações",
        "qs.tweaks.title": "Truques das configurações rápidas",
        "qs.tweaks.qs_show_auto_brightness.title": "Botão de brilho adaptável",
        "qs.tweaks.qs_show_auto_brightness.desc":
            "Mostrar o ícone de brilho adaptável nas configurações rápidas",
        "qs.tweaks.qs_show_brightness_slider.title": "Barra de brilho",
        "qs.tweaks.qs_show_brightness_slider.desc":
            "Mostrar a barra de brilho deslizante nas configurações rápidas",
        "qs.tweaks.qs_show_brightness_slider.v_0": "Não mostrar",
        "qs.tweaks.qs_show_brightness_slider.v_1":
            "Mostrar apenas quando expandido",
        "qs.tweaks.qs_show_brightness_slider.v_2": "Mostrar sempre",
        "qs.tweaks.qs_tile_title_visibility.title": "Mostrar título nos ícones",
        "qs.tweaks.qs_tile_title_visibility.desc":
            "Ocultar/Mostrar o título dos ícones",
        "qs.tweaks.qs_rows_portrait.title": "Linhas da grade no modo retrato",
        "qs.tweaks.qs_columns_portrait.title":
            "Colunas da grade no modo retrato",
        "qs.tweaks.qs_rows_landscape.title": "Linhas da grade no modo paisagem",
        "qs.tweaks.qs_columns_landscape.title":
            "Colunas da grade no modo paisagem",
        "qs.colors.title": "Cor das configurações rápidas",
        "qs.colors.qs_panel_bg_use_fw.title": "Padrão do Framework",
        "qs.colors.qs_panel_bg_use_fw.desc":
            "Desativar QS e personalizações de cores Scrim",
        "qs.colors.qs_panel_bg_color.title": "Cor de fundo",
        "qs.colors.qs_panel_bg_color.desc":
            "Mudar a cor do fundo das configurações rápidas",
        "qs.colors.qs_panel_bg_alpha.title": "Fundo alpha",
        "qs.colors.qs_panel_bg_disco.title": "Discoteca dos Ícones",
        "qs.colors.qs_panel_bg_disco.desc":
            "Deixar os ícones das configurações rápidas coloridos como uma balada!",
        "statusbar.title": "Barra de status",
        "statusbar.cutouts.title": "Corte da tela",
        "statusbar.cutouts.display_cutout_mode.title": "Modo de corte",
        "statusbar.cutouts.display_cutout_mode.v_0": "Normal",
        "statusbar.cutouts.display_cutout_mode.v_1": "Imersivo",
        "statusbar.cutouts.display_cutout_mode.v_2": "Oculto",
        "statusbar.cutouts.stock_statusbar_in_hide.title":
            "Barra de status padrão quando oculto",
        "statusbar.cutouts.stock_statusbar_in_hide.desc":
            "Usar a altura padrão da barra de status (geralmente pequena) no modo oculto",
        "statusbar.cutouts.sysui_rounded_size.title":
            "Raio dos cantos arredondados",
        "statusbar.clock.title": "Relógio",
        "statusbar.clock.smartclock.title": "Relógio inteligente",
        "statusbar.clock.smartclock.desc":
            "Ocultar o relógio quando há um período de inatividade",
        "statusbar.icons.title": "Ícones da barra de status",
        "statusbar.icons.show_fourg_icon.title": "Ícone do 4G",
        "statusbar.icons.show_fourg_icon.desc":
            "Mostrar o ícone 4G ao invés do ícone LTE",
        "statusbar.icons.show_volte_icon.title": "Ícone VoLTE",
        "statusbar.icons.show_volte_icon.desc": "Mostrar ícone HD para o VoLTE",
        "statusbar.icons.roaming_indicator_icon.title":
            "Ícone de sinal do telefone",
        "statusbar.icons.roaming_indicator_icon.desc":
            "Mostrar o ícone de sinal do telefone na barra de status",
        "statusbar.icons.systemui_tuner_statusbar.title":
            "Ícones do sistema na barra de status",
        "statusbar.icons.systemui_tuner_statusbar.desc":
            "Desativar/Ativar ícones do sistema na barra de status",
        "statusbar.nettraffic.title": "Monitor do tráfego da rede",
        "statusbar.nettraffic.network_traffic_location.title":
            "Local onde será exibido",
        "statusbar.nettraffic.network_traffic_location.v_0": "Não exibir",
        "statusbar.nettraffic.network_traffic_location.v_1": "Barra de status",
        "statusbar.nettraffic.network_traffic_location.v_2":
            "Configurações rápidas",
        "statusbar.nettraffic.network_traffic_autohide.title": "Auto-ocultar",
        "statusbar.nettraffic.network_traffic_autohide.desc":
            "Ocultar o monitor de tráfego quando não há tráfego",
        "statusbar.nettraffic.network_traffic_unit_type.title":
            "Unidade de medida usada",
        "statusbar.nettraffic.network_traffic_unit_type.v_0":
            "Bytes (8x maior que bits)",
        "statusbar.nettraffic.network_traffic_unit_type.v_1":
            "Bits (8x menor que bytes)",
        "statusbar.battery.title": "Bateria",
        "statusbar.battery.status_bar_battery_style.title": "Estilo da bateria",
        "statusbar.battery.status_bar_battery_style.v_0": "Retrato (em pé)",
        "statusbar.battery.status_bar_battery_style.v_1": "Círculo",
        "statusbar.battery.status_bar_battery_style.v_2": "Círculo pontilhado",
        "statusbar.battery.status_bar_battery_style.v_3": "Círculo sólido",
        "statusbar.battery.status_bar_battery_style.v_4": "Apenas texto",
        "statusbar.battery.status_bar_battery_style.v_5": "Ocultado",
        "statusbar.battery.status_bar_show_battery_percent.title":
            "Porcentagem da bateria",
        "statusbar.battery.status_bar_show_battery_percent.v_0": "Ocultado",
        "statusbar.battery.status_bar_show_battery_percent.v_1":
            "Dentro do ícone",
        "statusbar.battery.status_bar_show_battery_percent.v_2":
            "Ao lado do ícone",
        "statusbar.battery.qs_header_show_battery_percent.title":
            "Porcentagem nas configurações rápidas",
        "statusbar.battery.qs_header_show_battery_percent.desc":
            "Mostrar a estimativa de duração da bateria no cabeçalho das configurações rápidas",
        "system.title": "Sistema & Gestos",
        "system.buttons.title": "Botões",
        "system.buttons.volume_button_music_control.title":
            "Botões de volume para mudar de faixa",
        "system.buttons.volume_button_music_control.desc":
            "Pressione por um tempo nos botões de volume para Avançar/Voltar a faixa",
        "system.buttons.advanced_reboot.title": "Menu de reinício avançado",
        "system.buttons.advanced_reboot.desc":
            "Mostrar outras opções no menu de energia",
        "system.gestures.title": "Gestos",
        "system.gestures.double_tap_sleep_lockscreen.title":
            "Bloquear tela com duplo toque na tela de bloqueio",
        "system.gestures.double_tap_sleep_lockscreen.desc":
            "Desligar a tela com um duplo toque em um espaço vazio da tela de bloqueio",
        "system.gestures.three_finger_gesture.title":
            "Captura de tela com três dedos",
        "system.gestures.three_finger_gesture.desc":
            "Arraste para baixo com três dedos para uma captura de tela",
        "system.gestures.pulse_on_new_tracks.title": "AOD para músicas",
        "system.gestures.pulse_on_new_tracks.desc":
            "Mostrar Tela Ambiente (AOD) quando uma nova faixa de música é tocada",
        "system.navigation.title": "Navegação",
        "system.navigation.sysui_nav_bar_hint.title":
            "Mostrar a pílula de gestos",
        "system.navigation.sysui_nav_bar_hint.desc":
            "Mudar a navegação para Botões/Gestos",
        "system.navigation.navigation_handle_width.title":
            "Comprimento da pílula de navegação",
        "system.navigation.sysui_nav_bar_inverse.title":
            "Trocar ordem dos botões de navegação",
        "system.navigation.sysui_nav_bar_inverse.desc":
            "Trocar ordem dos botões de navegação, se usar o layout de 3 botões",
        "system.navigation.systemui_tuner_navbar.title":
            "Modificar barra de navegação",
        "system.navigation.systemui_tuner_navbar.desc":
            "Modificar o layout da barra de navegação",
        "system.network.title": "Rede",
        "system.network.tethering_allow_vpn_upstreams.title":
            "Permitir que os usuários usem VPN's",
        "system.network.tethering_allow_vpn_upstreams.desc":
            "Permitir que usuários de Ponto de Acesso/Tethering usem a conexão VPN deste dispositivo ",
        "system.packagemanager.title": "Gerenciador de pacotes",
        "system.packagemanager.allow_signature_fake.title":
            "Falsificação de assinatura do pacote",
        "system.packagemanager.allow_signature_fake.desc":
            "Permitir assinaturas falsas (pode ser útil para microG)",
        "system.notifications.title": "Notificações",
        "system.notifications.less_boring_heads_up.title":
            "Notificações flutuantes menos chatas",
        "system.notifications.less_boring_heads_up.desc":
            "Apenas receber notificações flutuantes em caso de chamadas ou apps de mensagem",
        "themes.title": "Themes",
        "themes.header.search_settings": "Search settings",
        "themes.themes.title": "Themes",
        "themes.themes.system_accent.title": "Accent color",
        "themes.themes.system_accent.desc": "Pick your favourite color!",
        "themes.themes.system_accent.cancel": "Cancel",
        "themes.themes.system_accent.confirm": "Confirm",
        "themes.themes.system_accent.light_color.title": "Light",
        "themes.themes.system_accent.light_color.light_warning":
            "Light color is too light",
        "themes.themes.system_accent.light_color.dark_warning":
            "Light color is too dark",
        "themes.themes.system_accent.dark_color.title": "Dark",
        "themes.themes.system_accent.dark_color.light_warning":
            "Dark color is too light",
        "themes.themes.system_accent.dark_color.dark_warning":
            "Dark color is too dark",
        "themes.themes.system_accent.calculate_shades_label":
            "Auto-magically calculate alt shades",
        "themes.themes.system_icon_shape.title": "Icon shape",
        "themes.themes.system_icon_pack.title": "System icon pack",
        "themes.themes.systemui_plugin_volume.title": "Volume panel",
        "themes.themes.systemui_plugin_volume.v_aosp": "AOSP",
        "themes.themes.systemui_plugin_volume.v_compact": "Compact",
        "themes.themes.systemui_plugin_volume.v_oreo": "Oreo",
        "themes.themes.systemui_plugin_volume.v_tiled": "Tiled",
        "themes.themes.volume_panel_on_left.title": "Volume panel direction",
        "themes.themes.volume_panel_on_left.v_0": "Right",
        "themes.themes.volume_panel_on_left.v_1": "Left",
        "themes.themes.sysui_colors_active.title": "IU do sistema colorido",
        "themes.themes.sysui_colors_active.desc":
            "Telas coloridas e QS do papel de parede",
        "audiofx.title": "AudioFX",
        "audiofx.status.on": "\\Ligado",
        "audiofx.status.off": "Desligado",
        "audiofx.audio_preset.title": "Audio preset",
        "audiofx.headset_profile.title": "Perfil do headphone",
        "audiofx.headset_profile.default": "Modo padrão",
        "lockscreen.title": "Tela de bloqueio",
        "lockscreen.clocks.title": "Relógios",
        "lockscreen.clocks.lock_screen_clock.title":
            "Relógio da tela de bloqueio",
        "lockscreen.clocks.lock_screen_clock.v_default": "Padrão",
        "lockscreen.clocks.lock_screen_clock.v_bubble": "Bolha",
        "lockscreen.clocks.lock_screen_clock.v_analog": "Analógico",
        "lockscreen.clocks.lock_screen_clock.v_type": "Por extenso",
        "lockscreen.clocks.lock_screen_clock.v_bold": "Negrito",
        "lockscreen.clocks.lock_screen_clock.v_sammy": "Samsumg",
        "lockscreen.clocks.lock_screen_clock.v_sammybold": "Samsung em negrito",
        "lockscreen.clocks.lock_screen_clock.v_sfuny": "SFUNY",
        "lockscreen.albumart.title": "Capa do álbum",
        "lockscreen.albumart.lockscreen_media_metadata.title":
            "Tela de bloqueio com capa ",
        "lockscreen.albumart.lockscreen_media_metadata.desc":
            "Mostrar a capa do álbum na tela de bloqueio",
        "lockscreen.albumart.lockscreen_media_blur.title":
            "Nível de desfoque na tela de bloqueio",
        "lockscreen.albumart.lockscreen_media_blur.desc":
            "Configurar a intensidade do desfoque da capa do álbum na tela de bloqueio",
        "lockscreen.tuner.title": "Atalhos da tela de bloqueio",
        "lockscreen.tuner.systemui_tuner_lockscreen.title":
            "Ações e apps na tela de bloqueio",
        "lockscreen.tuner.systemui_tuner_lockscreen.desc":
            "Gerenciar os atalhos na tela de bloqueio",
        "preferences.colorpicker.light_error": "A cor é muito clara",
        "preferences.colorpicker.dark_error": "A cor é muito escura",
        "preferences.colorpicker.light_warning":
            "A cor é muito clara, mas pode ser normalizada!",
        "preferences.colorpicker.dark_warning":
            "A cor é muito escura, mas pode ser normalizada!",
      };
}
