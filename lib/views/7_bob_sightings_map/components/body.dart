import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/heard_page/home_state.dart';
import '../../4_hear_bob/heard_bob.dart';
import '../../5_i_heard_bob/i_heard_bob.dart';
import '../../common_widget/bottom_buttons.dart';
import '../../common_widget/custom_back_button.dart';
import '../../common_widget/custom_title.dart';
import '../../common_widget/title_back.dart';
import 'maps.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Timer timer;

  void changeFirstAccess() {
    context.read<HomeState>().changeFirstAccess();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Mappa(),
        const CustomTitle(
          title: "Bob Sightings Map",
          color: kColor3,
          icon: "assets/icons/eye.svg",
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              BottomButton(
                  color: kColor1,
                  title: "Hear Bob",
                  iconPath: "assets/icons/music.svg",
                  onPressed: () {
                    Navigator.pushNamed(context, HearBobScreen.routeName);
                  }),
              BottomButton(
                  color: kColor2,
                  title: "Hey, I heard Bob!",
                  iconPath: "assets/icons/gps.svg",
                  onPressed: () {
                    if (Provider.of<HomeState>(context, listen: false)
                        .firstAccess) {
                      changeFirstAccess();
                      showDialog(
                          useSafeArea: false,
                          barrierDismissible: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) => _showDisclaimer(context));

                      timer = Timer(const Duration(seconds: 25), () {
                        Navigator.pop(context);

                        Navigator.pushNamed(context, IHeardBobScreen.routeName);
                      });
                    } else {
                      Navigator.pushNamed(context, IHeardBobScreen.routeName);
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showDisclaimer(BuildContext context) {
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
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/images/sfondo-welcome2.svg",
                    fit: BoxFit.cover,
                    //width: ScreenUtil().screenWidth,
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
                    margin: EdgeInsets.symmetric(horizontal: 0.h),
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
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, IHeardBobScreen.routeName);
                                        setState(() {
                                          timer.cancel();
                                        });
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
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ])),
        ]),
      ),
    );
  }
}
