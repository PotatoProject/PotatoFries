import 'package:potato_fries/utils/methods.dart';

class DEBUG {
  bool versionCheckDisabled = false;
  bool compatCheckDisabled = false;
  Map _versionSpoof;

  set versionSpoof(Map val) => _versionSpoof = val;

  Map get versionSpoof => isVersionValid(_versionSpoof) ? _versionSpoof : null;
}
