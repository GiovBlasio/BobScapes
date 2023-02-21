import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        await Future.delayed(
            const Duration(milliseconds: 500), () => Navigator.pop(context));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/icon-back.svg",
            height: 13.h,
            width: 16.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            "BACK",
            style: TextStyle(
                //height: 16,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
