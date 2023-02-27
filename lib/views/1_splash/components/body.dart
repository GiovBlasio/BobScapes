import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../2_welcome/welcome_screen.dart';
import '../../common_widget/logo_animated.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool animate = false;
  bool opacity = false;

  late double topLogo;
  late double leftLogo;
  late double bottomTextRow;
  // late double bottomBackground;
  // late double imageWidth;
  late double logoHeight;
  late double logoWidth;
  //late double leftFirstPin;
  //late double bottomMainPhrase;
  late double bobwhiteTop;
  late double onOurTop;
  late double landscapesTop;

  @override
  void initState() {
    super.initState();
    topLogo = 275.h;
    leftLogo = 40.67.w;
    bottomTextRow = -100.h;
    //  bottomBackground = 0;
    //imageWidth = 100.w;
    logoHeight = 100.25.h;
    logoWidth = 296.w;
    bobwhiteTop = -204.h;
    onOurTop = -153.h;
    landscapesTop = -102.h;
    _initialization();
  }

  void _initialization() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity = true;
      topLogo = 290.59.h;
      bottomTextRow = 31.h;
      // bottomBackground = 100.h;
    });

    await Future.delayed(const Duration(milliseconds: 2000));

    setState(() {
      animate = true;
      topLogo = 315.59.h;
      leftLogo = 24.67.w;
      //imageWidth = imageWidth + 100;
      logoHeight = 85.25.h;
      logoWidth = 276.w;
      bobwhiteTop = 419.59.h;
      onOurTop = 470.59.h;
      landscapesTop = 521.59.h;
    });

    await Future.delayed(
        const Duration(milliseconds: 2000),
        () => Navigator.of(context)
          ..pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const WelcomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1, 0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
             //   final offsetAnimation = animation.drive(tween);

                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: animate ? 0 : 1,
            duration: const Duration(seconds: 1),
            child: SvgPicture.asset(
              "assets/images/sfondo1.svg",
              fit: BoxFit.cover,
              // width: ScreenUtil().screenWidth,
            ),
          ),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: animate ? 1 : 0,
            duration: const Duration(seconds: 1),
            child: SvgPicture.asset(
              "assets/images/sfondo-welcome2.svg",
              fit: BoxFit.cover,
              //  width: ScreenUtil().screenWidth,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          bottom: bottomTextRow,
          left: 12.w,
          right: 12.w,
          child: AnimatedOpacity(
            opacity: opacity ? 1 : 0,
            duration: const Duration(seconds: 2),
            child: Row(
              children: [
                const Spacer(),
                SvgPicture.asset(
                  "assets/images/wlfw.svg",
                ),
                const Spacer(
                  flex: 2,
                ),
                SvgPicture.asset(
                  "assets/images/quail-forever.svg",
                ),
                const Spacer(
                  flex: 2,
                ),
                Image.asset(
                  "assets/images/gamelabmartin.png",
                  //height: 90,
                  scale: 3,
                ),
                const Spacer()
              ],
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: leftLogo,
            top: topLogo,
            child: AnimatedLogo(
              duration: const Duration(seconds: 1),
              logoHeight: logoHeight,
              logoWidth: logoWidth,
            )
            // SvgPicture.asset(
            //   "assets/images/logo-bobscapes.svg",
            //   height: logoHeight,
            //   width: logoWidth,
            //   alignment: Alignment.centerLeft,
            // ),
            ),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          top: bobwhiteTop,
          left: 38.w,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 51.sp,
                    color: kPrimaryColor,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    const TextSpan(text: 'Bobwhite\n'),
                    TextSpan(
                      text: "on our\nlandscapes",
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 51.sp,
                        color: kPrimaryColor,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // TextSpan(
                    //   text: "submitting",
                    //   style: TextStyle(
                    //     height: 1.1,
                    //     fontSize: 51.sp,
                    //     color: kTextColor,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: "your",
                    //   style: TextStyle(
                    //     height: 1.1,
                    //     fontSize: 51.sp,
                    //     color: kTextColor,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: "for",
                    //   style: TextStyle(
                    //     height: 1.1,
                    //     fontSize: 51.sp,
                    //     color: kTextColor,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // TextSpan(
                    //   text: "sighting",
                    //   style: TextStyle(
                    //     height: 1.1,
                    //     fontSize: 51.sp,
                    //     color: kTextColor,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Text(
              //   "Thank you\nfor\nsubmitting\nyour\nsighting!",
              //   style: TextStyle(
              //     height: 1.1,
              //     fontSize: 51.sp,
              //     color: kTextColor,
              //     fontFamily: 'Manrope',
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
            ],
          ),
        ),
        // AnimatedPositioned(
        //   duration: const Duration(seconds: 1),
        //   left: 38.w,
        //   top: bobwhiteTop,
        //   child: Text(
        //     "Bobwhite",
        //     style: TextStyle(
        //       fontFamily: 'Manrope',
        //       fontWeight: FontWeight.w700,
        //       color: kPrimaryColor,
        //       fontSize: 51.sp,
        //     ),
        //   ),
        // ),
        // AnimatedPositioned(
        //   duration: const Duration(seconds: 1),
        //   left: 38.w,
        //   top: onOurTop,
        //   child: Text(
        //     "on our",
        //     style: TextStyle(
        //       fontFamily: 'Manrope',
        //       fontWeight: FontWeight.w400,
        //       color: kPrimaryColor,
        //       fontSize: 51.sp,
        //     ),
        //   ),
        // ),
        // AnimatedPositioned(
        //   duration: const Duration(seconds: 1),
        //   left: 38.w,
        //   top: landscapesTop,
        //   child: Text(
        //     "landscapes",
        //     style: TextStyle(
        //       fontFamily: 'Manrope',
        //       fontWeight: FontWeight.w400,
        //       color: kPrimaryColor,
        //       fontSize: 51.sp,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
