import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/custom/accent_picker.dart';

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
}
