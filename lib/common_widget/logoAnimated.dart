import 'package:bobscapes/common_widget/logo.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedLogo extends ImplicitlyAnimatedWidget {
  const AnimatedLogo(
      {required this.iconColor,
      required this.iconSize,
      required this.textSize,
      required this.textColor,
      super.key,
      super.curve,
      required super.duration,
      super.onEnd});

  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double textSize;

  @override
  AnimatedWidgetBaseState<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends AnimatedWidgetBaseState<AnimatedLogo> {
  Tween<double>? _iconSize;
  Tween<double>? _textSize;

  @override
  Widget build(BuildContext context) {
    return Logo(
      iconColor: Colors.white,
      textColor: Colors.white,
      iconSize: _iconSize!.evaluate(animation),
      textSize: _textSize!.evaluate(animation),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _iconSize = visitor(_iconSize, widget.iconSize,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _textSize = visitor(_textSize, widget.textSize,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }
}
