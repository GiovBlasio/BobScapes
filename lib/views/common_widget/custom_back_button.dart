import 'package:bobscapes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/icon-back.svg",
            height: 13,
            width: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "BACK",
            style: TextStyle(
                //height: 16,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
