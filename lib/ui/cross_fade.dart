import 'dart:async';

import 'package:flutter/material.dart';

class CrossFadePeriodic extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;

  CrossFadePeriodic({this.firstChild, this.secondChild});

  @override
  _CrossFadePeriodicState createState() => _CrossFadePeriodicState();
}

class _CrossFadePeriodicState extends State<CrossFadePeriodic> {
  Timer timer;
  int show = 1;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (t) {
      if (!mounted) return;
      setState(() => show = show == 1 ? 2 : 1);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: AnimatedCrossFade(
        firstChild: widget.firstChild,
        secondChild: widget.secondChild,
        duration: Duration(milliseconds: 300),
        firstCurve: Curves.easeInOut,
        secondCurve: Curves.easeInOut,
        crossFadeState:
            show == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }
}
