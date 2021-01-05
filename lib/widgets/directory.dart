import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/custom/accent_picker.dart';
import 'package:potato_fries/widgets/custom/icon_pack_picker.dart';
import 'package:potato_fries/widgets/custom/icon_shape_picker.dart';
import 'package:potato_fries/widgets/custom/lock_screen_clock_picker.dart';

void registerCustomWidgets() {
  ObjectGen.register<AccentPicker>(() => AccentPicker());
  ObjectGen.register<IconPackPicker>(() => IconPackPicker());
  ObjectGen.register<IconShapePicker>(() => IconShapePicker());
  ObjectGen.register<LockScreenClockPicker>(() => LockScreenClockPicker());
}
