import 'package:flutter/material.dart';
import 'package:potato_fries/backend/extensions.dart';
import 'package:potato_fries/ui/theme.dart';

class FriesSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const FriesSwitch({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _FriesSwitchState createState() => _FriesSwitchState();
}

class _FriesSwitchState extends State<FriesSwitch>
    with TickerProviderStateMixin {
  late final AnimationController _positionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    value: widget.value ? 1 : 0,
  );
  final AlignmentGeometryTween _thumbPositionTween = AlignmentGeometryTween(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );
  Set<MaterialState> get _states => {if (widget.value) MaterialState.selected};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FriesSwitch old) {
    _positionController.animateTo(widget.value ? 1 : 0);

    super.didUpdateWidget(old);
  }

  @override
  Widget build(BuildContext context) {
    final FriesThemeData theme = context.friesTheme;
    final Color trackColor =
        theme.materialTheme.switchTheme.trackColor!.resolve(_states)!;
    final Color thumbColor =
        theme.materialTheme.switchTheme.thumbColor!.resolve(_states)!;

    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!widget.value);
      },
      onHorizontalDragUpdate: (details) {
        _positionController.value += details.primaryDelta! / 48;
      },
      onHorizontalDragEnd: (details) {
        widget.onChanged?.call(_positionController.value > 0.5);
      },
      child: SizedBox(
        width: 48,
        height: 24,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: trackColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: AnimatedBuilder(
              animation: _positionController,
              builder: (context, child) {
                return Align(
                  alignment: _thumbPositionTween.evaluate(_positionController)!,
                  child: child,
                );
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: thumbColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
