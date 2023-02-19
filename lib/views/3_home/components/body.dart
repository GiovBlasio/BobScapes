import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/heard_page/home_state.dart';
import '../../4_hear_bob/heard_bob.dart';
import '../../5_i_heard_bob/i_heard_bob.dart';
import '../../7_bob_sightings_map/bob_sightings.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  bool isDisclaimer = false;

  bool discalimerClosed = false;
  bool showQuail = true;

  late Timer timer;

  void changeFirstAccess() {
    context.read<HomeState>().changeFirstAccess();
  }

  @override
  Widget build(BuildContext context) {
    discalimerClosed = false;
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/sfondo2.svg",
            fit: BoxFit.fill,
            width: ScreenUtil().screenWidth,
          ),
        ),
        if (showQuail && !isDisclaimer)
          Positioned(
            bottom: 0.27.sh,
            left: 0.w,
            right: 0.w,
            child: Image.asset(
              "assets/images/quail.png",
              height: 0.42.sh,
              width: 0.73.sw,
            ),
          ),
        Positioned(
          bottom: 27.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 0.1,
                    padding: const EdgeInsets.only(left: 0),
                    onPressed: () {
                      setState(() {
                        isDisclaimer = !isDisclaimer;
                      });
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/icon-info.svg",
                      height: 25.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    HomeButton(
                      title: 'Hear Bob',
                      iconPath: "assets/icons/music.svg",
                      color: kColor1,
                      onPressed: () {
                        Navigator.pushNamed(context, HearBobScreen.routeName);
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    HomeButton(
                        title: 'Hey, I heard Bob!',
                        iconPath: "assets/icons/gps.svg",
                        color: kColor2,
                        onPressed: () {
                          setState(() {
                            showQuail = false;
                          });
                          if (Provider.of<HomeState>(context, listen: false)
                              .firstAccess) {
                            changeFirstAccess();

                            showDialog(
                              useSafeArea: false,
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => _showDisclaimer(context),
                            );

                            timer = Timer(const Duration(seconds: 25), () {
                              setState(() {
                                showQuail = true;
                              });
                              if (!discalimerClosed) {
                                Navigator.pop(context);

                                Navigator.pushNamed(
                                    context, IHeardBobScreen.routeName);
                              }
                            });
                          } else {
                            setState(() {
                              showQuail = true;
                            });

                            Navigator.pushNamed(
                                context, IHeardBobScreen.routeName);
                          }
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    HomeButton(
                      title: 'Bob Sightings Map',
                      iconPath: "assets/icons/eye.svg",
                      color: kColor3,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          BobSightingsScreen.routeName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isDisclaimer)
          Positioned.fill(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
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
                          child: SingleChildScrollView(
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
                                          setState(() {
                                            isDisclaimer = !isDisclaimer;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
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
                                  ),
                                ),
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
                        )),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  Stack _showDisclaimer(BuildContext context) {
    return Stack(children: [
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Stack(alignment: Alignment.bottomCenter, children: [
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
                margin: EdgeInsets.symmetric(horizontal: 0.h),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                        color: kColor3,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 30.w, right: 10.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
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
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, IHeardBobScreen.routeName);
                                      setState(() {
                                        timer.cancel();
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 500));
                                      setState(() {
                                        showQuail = true;

                                        discalimerClosed = true;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
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
                              ),
                            ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ])),
    ]);
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    required this.title,
    required this.iconPath,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(8),
        overlayColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(
            double.infinity,
            84.h,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: kTextColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700),
            ),
            const Spacer(
              flex: 5,
            ),
            SvgPicture.asset(
              iconPath,
              height: 35.h,
              color: kTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
