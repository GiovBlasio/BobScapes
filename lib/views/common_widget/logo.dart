import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    required this.iconColor,
    required this.iconSize,
    required this.textSize,
    required this.textColor,
    Key? key,
  }) : super(key: key);

  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/icons/eye.svg",
          height: (iconSize),
          color: iconColor,
        ),
        const SizedBox(
          width: (8),
        ),
        Text(
          "Bobscapes".toUpperCase(),
          style: TextStyle(
              fontSize: (textSize),
              fontFamily: "FjallaOne",
              color: textColor,
              // fontFamily: 'Manrope',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
