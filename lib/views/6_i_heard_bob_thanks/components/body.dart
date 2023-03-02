import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../common_widget/custom_back_button.dart';
import '../../common_widget/title_back.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/sfondo5.svg",
            fit: BoxFit.cover,
            //width: ScreenUtil().screenWidth,
          ),
        ),
        Positioned(
          top: 233.25.h,
          left: 45.w,
          child: SvgPicture.asset(
            "assets/images/logo-bobscapes.svg",
            width: 275.43.w,
            height: 85.h,
          ),
        ),
        Positioned(
          top: 350.25.h,
          left: 56.w,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 51.sp,
                    color: kTextColor,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    const TextSpan(text: 'Thank you\n'),
                    TextSpan(
                      text: "for\nsubmitting\nyour\nsighting!",
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 51.sp,
                        color: kTextColor,
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
        // Positioned(
        //   top: 372.25.h,
        //   left: 56.w,
        //   child: Text(
        //     "for",
        //     style: TextStyle(
        //       height: 1.1,
        //       fontSize: 51.sp,
        //       color: kTextColor,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   top: 423.25.h,
        //   left: 56.w,
        //   child: Text(
        //     "submitting",
        //     style: TextStyle(
        //       height: 1.1,
        //       fontSize: 51.sp,
        //       color: kTextColor,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
        // Positioned(

        //   top: 474.25.h,
        //   left: 56.w,
        //   child: Text(
        //     "your",
        //     style: TextStyle(
        //       height: 1.1,
        //       fontSize: 51.sp,
        //       color: kTextColor,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
        // Positioned(
        //   top: 525.25.h,
        //   left: 56.w,
        //   child: Text(
        //     "sighting!",
        //     style: TextStyle(
        //       height: 1,
        //       fontSize: 51.sp,
        //       color: kTextColor,
        //       fontWeight: FontWeight.w400,
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 120.h,
          left: 16.w,
          child: IconButton(
            color: kTextColor,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            onPressed: () => showDialog(
              useSafeArea: false,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.zero,
                child: _showDisclaimer(context),
              ),
            ),
            icon: SvgPicture.asset(
              "assets/icons/icon-info.svg",
              height: 25.h,
            ),
          ),
        ),
        Positioned(
          bottom: 27.h,
          left: 16.w,
          right: 16.w,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(kColor3),
              shadowColor: MaterialStateProperty.all(Colors.grey),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(double.infinity, 84.h),
              ),
              backgroundColor: MaterialStateProperty.all(kColor3),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0),
              ),
            ),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName('/home')),
            child: Text(
              'Back to home',
              style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: kTextColor),
            ),
          ),
        ),
      ],
    );
  }

  _showDisclaimer(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kAppbarColor,
            leadingWidth: 80.w,
            leading: const CustomBackButton(),
            title: const TitleBack()),
        body: Stack(children: [
          Positioned.fill(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/images/sfondo-welcome2.svg",
                    fit: BoxFit.cover,
                    //  width: ScreenUtil().screenWidth,
                  ),
                ),
                Positioned(
                  bottom: 400.h,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/quail-reflected.png",
                    height: 270.h,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Positioned(
                  height: 453.h,
                  left: 16.w,
                  right: 16.w,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 10.w),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "Disclaimer",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.sp),
                                    ),
                                    IconButton(
                                      splashRadius: 0.1,
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: kTextColor,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                            left: 30.w,
                                            top: 25.h,
                                            bottom: 5.h,
                                            right: 40.w,
                                          ),
                                          child: Text(
                                            "The exact location of your sightings will not be shared with the public.",
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            left: 30.w,
                                            top: 15.h,
                                            bottom: 5.h,
                                            right: 40.w,
                                          ),
                                          child: Text(
                                            "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
