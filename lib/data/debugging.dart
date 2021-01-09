import 'package:potato_fries/utils/methods.dart';

class Debug {
  bool versionCheckDisabled = false;
  bool compatCheckDisabled = false;
  Map<String, dynamic> _versionSpoof;

  set versionSpoof(Map<String, dynamic> val) => _versionSpoof = val;

  Map<String, dynamic> get versionSpoof =>
      isVersionValid(_versionSpoof) ? _versionSpoof : null;
}
