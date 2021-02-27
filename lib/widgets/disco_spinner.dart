import 'dart:math' as math;

import 'package:flutter/material.dart';

class DiscoSpinner extends StatefulWidget {
  final bool isSpinning;
  final bool isEnabled;
  final Function onTap;
  final Widget child;
  final double size;

  DiscoSpinner({
    @required this.isSpinning,
    this.isEnabled = true,
    this.onTap,
    this.child,
    this.size = 36,
  });

  @override
  _DiscoSpinnerState createState() => _DiscoSpinnerState();
}

class _DiscoSpinnerState extends State<DiscoSpinner>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: math.pi * 2).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  void startAnim() => controller?.repeat();

  void stopAnim() => controller?.stop();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) return Container(child: widget.child);
    widget.isSpinning ? startAnim() : stopAnim();
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: animation.value,
            child: Container(
              height: widget.size,
              width: widget.size,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    Colors.red,
                    Colors.purpleAccent,
                    Colors.blue,
                    Colors.cyan,
                    Colors.green,
                    Colors.yellow,
                    Colors.red,
                  ],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
          widget.child ?? Container(),
        ],
      ),
    );
  }
}
