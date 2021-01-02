import 'dart:math';

import 'package:effectsplugin/effectsplugin.dart';
import 'package:flutter/material.dart';

class AudioFxProvider extends ChangeNotifier {
  EFFECT_TYPE audioFxType = EFFECT_TYPE.NONE;
  Effect currentEffect;
  List<double> bands = List.empty()..length = 7;
  bool _enabled = false;

  bool get enabled => _enabled;

  set enabled(bool enabled) {
    _enabled = enabled;
    currentEffect.setMusic(enabled);
    notifyListeners();
  }

  int _headset = 0;

  int get headset => _headset;

  set headset(int headset) {
    _headset = headset;
    currentEffect.setHeadsetType(headset);
    notifyListeners();
  }

  final eqProfiles = {
    '0,0,0,0,0,0,0': {
      'name': "Default",
      'color': null,
    },
    '4,2,-2,0,-2,-2,4': {
      'name': "Rock",
      'color': Color(0xffe96371),
    },
    '0,0,0,-2,-3,0,0': {
      'name': "Jazz",
      'color': Color(0xff63e99b),
    },
    '0,-3,-5,0,0,-3,0': {
      'name': "Pop",
      'color': Color(0xffe97e63),
    },
    '0,0,0,0,3,6,6': {
      'name': "Classical",
      'color': Color(0xff6377e9),
    },
    '3,3,-3,0,-3,0,2': {
      'name': "Hip Hop",
      'color': Color(0xffb563e9),
    },
    '2,4,-6,4,0,1,2': {
      'name': "Blues",
      'color': Color(0xff63a8e9),
    },
    '3,3,-1,0,-3,0,0': {
      'name': "Electronic",
      'color': Color(0xff9de963),
    },
    '0,0,-2,-2,2,2,0': {
      'name': "Country",
      'color': Color(0xffe98063),
    },
    '0,4,2,0,-2,-2,4': {
      'name': "Dance",
      'color': Color(0xffce63e9),
    },
    '2,0,0,-2,-4,0,0': {
      'name': "Metal",
      'color': Color(0xffe96384),
    },
    'OTHER': {
      'name': "Custom",
      'color': null,
    }
  };

  final List<String> headphones = [
    "Default Mode",
    "Mi Earbuds",
    "Mi In-Ear (2013)",
    "Mi Piston-1",
    "General",
    "General In-Ear",
    "Mi Earphones Basic",
    "Mi Piston-2",
    "Standard Edition",
    "Mi Headphones",
    "Youth Edition",
    "Color Edition",
    "Mi In-Ear",
    "Mi Capsule",
    "Mi In-Ear Pro",
    "Mi Comfort",
    "Mi Noise Cancelling Type-C",
    "Mi Noise Cancelling 3.5mm",
    "Mi Half In-Ear",
    "Mi In-Ear 2",
    "Mi Earphones Basic",
    "Mi Earphones",
  ];

  String get profile {
    final key = bands.map((e) => (e ?? 0.0).toInt()).toList().join(',');
    if (eqProfiles.containsKey(key)) {
      return eqProfiles[key]['name'];
    } else {
      return eqProfiles['OTHER']['name'];
    }
  }

  Color get profileColor {
    final key = bands.map((e) => (e ?? 0.0).toInt()).toList().join(',');
    if (eqProfiles.containsKey(key)) {
      return eqProfiles[key]['color'];
    } else {
      return eqProfiles['OTHER']['color'];
    }
  }

  Map get profileMap {
    Map ret = {};
    for (var key in eqProfiles.keys) {
      ret[eqProfiles[key]['name']] = eqProfiles[key]['name'];
    }
    return ret;
  }

  void setProfile(String name) {
    if (name == 'Custom') {
      final r = Random();
      for (int i = 0; i < (bands.length ?? 0); i++) {
        setBand(i, (r.nextInt(20) - 10).toDouble());
      }
      return;
    }
    for (var key in eqProfiles.keys) {
      if (eqProfiles[key]['name'] == name) {
        final bandData = key.split(',').map((e) => double.tryParse(e) ?? 0);
        for (int i = 0; i < bandData.length; i++) {
          setBand(i, bandData.elementAt(i));
        }
        return;
      }
    }
  }

  AudioFxProvider() {
    loadData();
  }

  double getSafeLevel(double level) {
    if (level < -10) level = -10;
    if (level > 10) level = 10;
    return level;
  }

  void setBand(int band, double level) async {
    level = getSafeLevel(level);
    bands[band] = level;
    await currentEffect.setLevel(band, level);
    notifyListeners();
    var newLevel = await currentEffect.getLevel(band);
    if (newLevel != level) {
      newLevel = getSafeLevel(newLevel);
      bands[band] = newLevel;
      notifyListeners();
    }
  }

  void loadData() async {
    if (await FX.mDirac.isDiracSupported()) {
      audioFxType = EFFECT_TYPE.DIRAC;
      currentEffect = FX.mDirac;
    } else if (await FX.mMi.isMiSupported()) {
      audioFxType = EFFECT_TYPE.MI;
      currentEffect = FX.mMi;
    }
    if (currentEffect == null) {
      notifyListeners();
      return;
    }
    for (int i = 0; i < await currentEffect.getNumBands(); i++)
      bands[i] = await currentEffect.getLevel(i);

    _enabled = await currentEffect.getMusic();
    final newHeadset = await currentEffect.getHeadsetType();
    _headset =
        newHeadset >= headphones.length ? headphones.length - 1 : newHeadset;
    notifyListeners();
  }
}
