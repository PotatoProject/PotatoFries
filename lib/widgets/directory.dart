import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/custom/accent_picker.dart';
import 'package:potato_fries/widgets/custom/icon_pack_picker.dart';
import 'package:potato_fries/widgets/custom/icon_shape_picker.dart';

enum WidgetType {
  COLOR_PICKER,
  COLOR_PICKER_DUAL,
  CUSTOM,
  DROPDOWN,
  SLIDER,
  SWITCH,
}

void registerCustomWidgets() {
  ObjectGen.register<AccentPicker>(() => AccentPicker());
  ObjectGen.register<IconPackPicker>(() => IconPackPicker());
  ObjectGen.register<IconShapePicker>(() => IconShapePicker());
}
