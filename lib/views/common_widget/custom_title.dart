import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    required this.title,
    required this.color,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final Color color;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      elevation: 10,
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15), vertical: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 47,
          color: color,
          child: Row(
            children: [
              const Spacer(
                flex: 8,
              ),
              Text(
                title,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 15.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 5,
              ),
              Flexible(
                flex: 2,
                child: SvgPicture.asset(
                  icon,
                  height: 30,
                  color: kTextColor,
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
