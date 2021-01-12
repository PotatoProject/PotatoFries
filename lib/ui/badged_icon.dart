import 'package:flutter/material.dart';

class BadgedIcon extends StatelessWidget {
  final Widget icon;
  final Widget badgeIcon;
  final double size;
  final double badgeSize;
  final AlignmentGeometry badgeAlignment;

  BadgedIcon({
    this.icon,
    this.badgeIcon,
    this.size = 24,
    this.badgeSize = 12,
    this.badgeAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.square(size),
      child: badgeIcon != null
          ? Stack(
              children: [
                ClipPath(
                  clipper: _BadgeClipper(
                    badgeAlignment ?? AlignmentDirectional.topEnd,
                    badgeSize,
                    Directionality.of(context),
                  ),
                  child: IconTheme.merge(
                    data: IconThemeData(size: size),
                    child: icon,
                  ),
                ),
                Align(
                  alignment: badgeAlignment ?? AlignmentDirectional.topEnd,
                  child: SizedBox.fromSize(
                    size: Size.square(badgeSize),
                    child: IconTheme.merge(
                      data: IconThemeData(size: badgeSize),
                      child: badgeIcon,
                    ),
                  ),
                ),
              ],
            )
          : SizedBox.fromSize(
              size: Size.square(size),
              child: IconTheme.merge(
                data: IconThemeData(size: size),
                child: icon,
              ),
            ),
    );
  }
}

class _BadgeClipper extends CustomClipper<Path> {
  final AlignmentGeometry alignment;
  final double size;
  final TextDirection direction;

  _BadgeClipper(
    this.alignment,
    this.size,
    this.direction,
  );

  @override
  Path getClip(Size _size) {
    final resolvedAlignment = alignment.resolve(direction);
    final halfWidth = _size.width / 2;
    final halfHeight = _size.height / 2;

    final x = resolvedAlignment.x * halfWidth + halfWidth;
    final y = resolvedAlignment.y * halfHeight + halfHeight;

    final xAdjust = size / 2 * resolvedAlignment.x;
    final yAdjust = size / 2 * resolvedAlignment.y;

    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & _size),
      Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(x - xAdjust, y - yAdjust),
            radius: size / 2 + size / 16,
          ),
        ),
    );
  }

  @override
  bool shouldReclip(_BadgeClipper old) {
    return this.alignment != old.alignment || this.size != old.size;
  }
}
