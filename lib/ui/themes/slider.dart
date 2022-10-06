import 'dart:math' as math;

import 'package:flutter/material.dart';

class FriesSliderThumbShape extends SliderComponentShape {
  const FriesSliderThumbShape({this.thumbRadius = 6.0});

  final double thumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;
    final double thumbOffset = (center.dx / parentBox.size.width) *
            (parentBox.size.width - thumbRadius * 2 - 4) +
        thumbRadius +
        2;

    canvas.drawCircle(
      Offset(thumbOffset, center.dy),
      thumbRadius,
      Paint()..color = color,
    );
  }
}

class FriesSliderTrackShape extends SliderTrackShape {
  const FriesSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    assert(trackHeight >= 0);

    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = trackLeft + parentBox.size.width;
    final double trackBottom = trackTop + trackHeight;

    return Rect.fromLTRB(
      math.min(trackLeft, trackRight),
      trackTop,
      math.max(trackLeft, trackRight),
      trackBottom,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);

    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are left: active, right: inactive,
    // but reversed for right to left text.
    final ColorTween activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final ColorTween inactiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledInactiveTrackColor,
      end: sliderTheme.inactiveTrackColor,
    );
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }
    final Size thumbSize =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete);
    final double thumbRadius = math.min(thumbSize.width, thumbSize.height) / 2;
    final double thumbStartOffset = (thumbCenter.dx / parentBox.size.width) *
            (parentBox.size.width - thumbRadius * 2 - 4) +
        thumbRadius * 2 +
        4;
    final double thumbEndOffset = (thumbCenter.dx / parentBox.size.width) *
        (parentBox.size.width - thumbRadius * 2 - 4);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Rect leftTrackSegment = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbStartOffset,
      trackRect.bottom,
    );
    final Rect rightTrackSegment = Rect.fromLTRB(
      thumbEndOffset,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    if (!leftTrackSegment.isEmpty) {
      context.canvas.drawRRect(
        RRect.fromRectAndRadius(
          leftTrackSegment,
          Radius.circular(trackRect.height / 2),
        ),
        leftTrackPaint,
      );
    }
    if (!rightTrackSegment.isEmpty) {
      context.canvas.drawRRect(
        RRect.fromRectAndRadius(
          rightTrackSegment,
          Radius.circular(trackRect.height / 2),
        ),
        rightTrackPaint,
      );
    }
  }
}

class FriesSliderOverlayShape extends RoundSliderOverlayShape {
  const FriesSliderOverlayShape();

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: 0.0,
      end: overlayRadius,
    );
    final Size thumbSize =
        sliderTheme.thumbShape!.getPreferredSize(true, isDiscrete);
    final double thumbRadius = math.min(thumbSize.width, thumbSize.height) / 2;
    final double thumbOffset = (center.dx / parentBox.size.width) *
            (parentBox.size.width - thumbRadius * 2 - 4) +
        thumbRadius +
        2;

    canvas.drawCircle(
      Offset(thumbOffset, center.dy),
      radiusTween.evaluate(activationAnimation),
      Paint()..color = sliderTheme.overlayColor!,
    );
  }
}
