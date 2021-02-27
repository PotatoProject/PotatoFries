import 'package:flutter/material.dart';

class AnimatedDisable extends StatelessWidget {
  final bool disabled;
  final Widget child;

  AnimatedDisable({@required this.disabled, @required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: disabled ? 0.5 : 1.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: IgnorePointer(
        ignoring: disabled,
        child: child,
      ),
    );
  }
}
