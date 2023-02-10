import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';

class AnimatedLogo extends ImplicitlyAnimatedWidget {
  const AnimatedLogo({
    required this.logoHeight,
    required this.logoWidth,
    super.key,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  final double logoHeight;
  final double logoWidth;

  @override
  AnimatedWidgetBaseState<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends AnimatedWidgetBaseState<AnimatedLogo> {
  Tween<double>? _logoHeight;
  Tween<double>? _logoWidth;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/logo-bobscapes.svg",
      width: _logoWidth!.evaluate(animation),
      height: _logoHeight!.evaluate(animation),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _logoHeight = visitor(_logoHeight, widget.logoHeight,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _logoWidth = visitor(_logoWidth, widget.logoWidth,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }
}
