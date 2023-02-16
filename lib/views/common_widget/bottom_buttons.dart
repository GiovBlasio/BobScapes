import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.color,
    required this.title,
    required this.iconPath,
    required this.onPressed,
    super.key,
  });

  final Color color;
  final String title;
  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, -4),
              ),
            ]),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          elevation: 10,
          margin: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              width: SizeConfig.screenWidth / 2,
              height: 63,
              color: color,
              child: Row(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    iconPath,
                    height: 25,
                    color: kTextColor,
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
