import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

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
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, -4),
              ),
            ]),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.r),
            ),
          ),
          elevation: 10,
          margin: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius:  BorderRadius.vertical(
              top: Radius.circular(12.r),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              width: 0.5.sw,
              height: 67.h,
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
                        fontSize: 15.sp,
                        fontFamily: 'Manrope',
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
