import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/ui/components/colorpicker.dart';
import 'package:potato_fries/ui/components/preferences/base.dart';
import 'package:potato_fries/ui/components/separated_flex.dart';

class ColorPickerPreferenceTile extends StatelessWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onColorChanged;
  final String title;
  final String? subtitle;
  final Widget? icon;
  final bool enabled;
  final VoidCallback? onLongPress;

  const ColorPickerPreferenceTile({
    required this.color,
    this.onColorChanged,
    required this.title,
    this.subtitle,
    this.icon,
    this.enabled = true,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferenceTile(
      leading: icon,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: ShortChip(
        child: Icon(
          Icons.circle,
          color: color.toColor(),
        ),
      ),
      enabled: enabled,
      onTap: () async {
        final HSLColor? newColor = await context.showBottomSheet(
          enableDrag: false,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxHeight: context.mediaQuery.size.height * 0.6,
            ),
            child: _ColorPickerSheet(
              initialColor: color,
              onConfirm: (color) => Navigator.pop(context, color),
              onCancel: () => Navigator.pop(context),
            ),
          ),
        );

        if (newColor != null) {
          onColorChanged?.call(newColor);
        }
      },
      onLongPress: onLongPress,
    );
  }
}

class _ColorPickerSheet extends StatefulWidget {
  final HSLColor initialColor;
  final ValueChanged<HSLColor?> onConfirm;
  final VoidCallback onCancel;

  const _ColorPickerSheet({
    required this.initialColor,
    required this.onConfirm,
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  _ColorPickerSheetState createState() => _ColorPickerSheetState();
}

class _ColorPickerSheetState extends State<_ColorPickerSheet> {
  late HSLColor color;

  @override
  void initState() {
    super.initState();
    color = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedFlex(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 80,
          width: double.infinity,
          child: ColorDisplay(
            color: color,
            onColorChanged: (newColor) => setState(
              () => color = newColor,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ColorPicker(
            color: color,
            onValueChanged: (newColor) => setState(
              () => color = newColor,
            ),
          ),
        ),
        SeparatedFlex(
          axis: Axis.horizontal,
          children: [
            OutlinedButton(
              onPressed: color != widget.initialColor
                  ? () => setState(() => color = widget.initialColor)
                  : null,
              child: const Text("Reset"),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: widget.onCancel,
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => widget.onConfirm(color),
              child: const Text("Confirm"),
            ),
          ],
          separator: const SizedBox(width: 16),
        ),
      ],
      separator: const SizedBox(height: 16),
    );
  }
}
