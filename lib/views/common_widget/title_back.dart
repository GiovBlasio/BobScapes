import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../1_splash/splash_screen.dart';

class TitleBack extends StatelessWidget {
  const TitleBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popUntil(ModalRoute.withName('/home'));
        Navigator.of(context).popAndPushNamed(SplashScreen.routeName);
      },
      child: SvgPicture.asset(
        "assets/images/logo-bobscapes.svg",
        height: 34.23.h,
      ),
    );
  }
}
