import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../3_home/home.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
  String page = 'Welcome';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/sfondo2.svg",
            fit: BoxFit.fill,
            width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
          top: 53.25.h,
          left: 110.w,
          right: 110.w,
          child: SvgPicture.asset(
            "assets/images/logo-bobscapes.svg",
            width: 171.43.w,
            height: 53.h,
          ),
        ),
        Positioned(
          top: 303.h,
          bottom: 0.h,
          left: 0.w,
          right: 0.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.40.sh,
                child: PageView(
                  onPageChanged: (value) {
                    setState(
                      () {
                        currentIndex = value;
                      },
                    );
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 57.w,
                        right: 43.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: kTextColor,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w700,
                              ),
                              children: const [
                                TextSpan(
                                  text: '> Welcome to\n',
                                ),
                                TextSpan(
                                  text: 'BOBSCAPES',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ',\nA Mobile App to Track Bobwhite Quail on Our Landscapes',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            "We appreciate your\ncontribution to conservation!",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 57.w,
                        right: 43.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "> Spotting Bob",
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: kTextColor,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Text(
                            "Using this app you can contribute to Bobwhite conservation efforts by reporting Bobwhite that you have heard or seen in your landscape",
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 20.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 47.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => buildDot(index: index),
                ),
              ),
            ],
          ),
        ),
        if (currentIndex == 1)
          Positioned(
            right: 14.5.w,
            left: 14.5.w,
            bottom: 27.h,
            child: TextButton(
              style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(8),
                overlayColor: MaterialStateProperty.all(kColor3),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 84.h),
                ),
                backgroundColor: MaterialStateProperty.all(kColor3),
              ),
              onPressed: () =>
                  Navigator.popAndPushNamed(context, HomeScreen.routeName),
              child: Row(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Enter",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        color: kTextColor),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Flexible(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/icons/union.svg",
                        height: 26.h,
                      )),
                ],
              ),
            ),
          ),
      ],
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 20.w),
      height: 21.h,
      width: currentIndex == index ? 21.h : 21.h,
      decoration: BoxDecoration(
        color: currentIndex == index ? kTextColor : kTextLightColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
