import 'package:flutter/material.dart';
import 'package:potato_fries/ui/themes/data.dart';

class FriesTheme extends StatelessWidget {
  final Widget child;
  final FriesThemeData data;

  const FriesTheme({
    required this.child,
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _FriesThemeInheritedWidget(
      data: data,
      child: Theme(
        child: child,
        data: data.materialTheme,
      ),
    );
  }

  static FriesThemeData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FriesThemeInheritedWidget>()!
        .data;
  }

  static FriesThemeData? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_FriesThemeInheritedWidget>()
        ?.data;
  }
}

class _FriesThemeInheritedWidget extends InheritedWidget {
  final FriesThemeData data;

  const _FriesThemeInheritedWidget({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant _FriesThemeInheritedWidget old) {
    return data != old.data;
  }
}

class AnimatedFriesTheme extends ImplicitlyAnimatedWidget {
  /// Creates an animated theme.
  ///
  /// By default, the theme transition uses a linear curve. The [data] and
  /// [child] arguments must not be null.
  const AnimatedFriesTheme({
    Key? key,
    required this.data,
    Curve curve = Curves.linear,
    Duration duration = kThemeAnimationDuration,
    VoidCallback? onEnd,
    required this.child,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  /// Specifies the color and typography values for descendant widgets.
  final FriesThemeData data;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  @override
  AnimatedWidgetBaseState<AnimatedFriesTheme> createState() =>
      _AnimatedThemeState();
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<AnimatedFriesTheme> {
  FriesThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
      _data,
      widget.data,
      (dynamic value) => FriesThemeDataTween(begin: value as FriesThemeData),
    )! as FriesThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return FriesTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}
