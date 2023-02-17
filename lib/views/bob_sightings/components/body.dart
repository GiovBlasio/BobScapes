import 'dart:async';

import 'package:bobscapes/provider/heard_page/home_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/common_widget/bottom_buttons.dart';
import 'package:bobscapes/views/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: kAppbarColor,
            leading: Container(),
            title: SvgPicture.asset(
              "assets/images/logo-bobscapes.svg",
              height: 34.23,
            ),
          ),
          body: Stack(children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/images/sfondo-welcome2.svg",
                fit: BoxFit.fill,
                width: SizeConfig.screenWidth,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Positioned(
                    bottom: getProportionateScreenHeight(400),
                    left: 25,
                    child: Image.asset(
                      "assets/images/quail-reflected.png",
                      height: getProportionateScreenHeight(200),
                    ),
                  ),
                  Positioned(
                    height: getProportionateScreenHeight(525 - 72),
                    left: 25,
                    right: 25,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      elevation: 10,
                      margin: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(0)),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(15)),
                          decoration: const BoxDecoration(
                              color: kColor3,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(30),
                                      right: getProportionateScreenWidth(10)),
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
                                            fontWeight: FontWeight.w600,
                                            
                                            fontSize: 20.sp),
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
                                          Navigator.pushNamed(context,
                                              IHeardBobScreen.routeName);
                                          setState(() {
                                            timer.cancel();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(30),
                                        top: getProportionateScreenHeight(20),
                                        bottom: getProportionateScreenHeight(5),
                                        right: getProportionateScreenWidth(40)),
                                    child: Text(
                                      "The exact location of your sightings will not be shared with the public.",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(30),
                                        top: getProportionateScreenHeight(20),
                                        bottom: getProportionateScreenHeight(5),
                                        right: getProportionateScreenWidth(40)),
                                    child: Text(
                                      "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                ])),
          ]),
        ));
  }
}
