import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0.008.sh),
          width: double.infinity,
          height: 52.h,
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
                    fontSize: 19.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700),
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
