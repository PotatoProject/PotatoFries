import 'package:flutter/material.dart';
import 'package:potato_fries/ui/svg_icon.dart';
import 'package:simple_animations/simple_animations.dart';

BorderRadius _kBorderRadius = BorderRadius.circular(12);

class CroquetteBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('color1').add(
        Duration(seconds: 5),
        ColorTween(
          begin: Color(0xFF9544E7),
          end: Color(0xFF2EE8BB),
        ),
      ),
      Track('color2').add(
        Duration(seconds: 5),
        ColorTween(
          begin: Color(0xFF2EE8BB),
          end: Color(0xFF9544E7),
        ),
      ),
    ]);
    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
            ),
            child: svgIcon(
              'assets/croquette.svg',
              width: 256,
              height: 88,
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                animation['color1'],
                animation['color2'],
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              tileMode: TileMode.clamp,
            ),
            borderRadius: _kBorderRadius,
          ),
        );
      },
    );
  }
}
