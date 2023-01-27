import 'package:bobscapes/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'heard_page1.dart';
import 'heard_page2.dart';
import 'heard_page3.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController controller = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: getProportionateScreenHeight(70),
            top: getProportionateScreenHeight(50),
            left: 0,
            right: 0,
            child: Center(
              child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  controller: controller,
                  children: const [
                    Center(child: HeardPage1()),
                    Center(child: HeardPage2()),
                    Center(child: HeardPage3())
                  ]),
            )),
        Positioned(
            height: getProportionateScreenHeight(50),
            width: SizeConfig.screenWidth,
            child: const CustomTitle(title: "I Heard a Bob!")),
        Positioned(
            bottom: getProportionateScreenHeight(70),
            right: 0,
            left: 0,
            child: buildButtons()),
        Positioned(
            bottom: 0,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.popAndPushNamed(
                      context, BobSightingsScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, -4),
                          ),
                        ]),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      elevation: 10,
                      margin: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10)),
                          width: SizeConfig.screenWidth / 2,
                          height: getProportionateScreenHeight(75),
                          color: Colors.white,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(
                              //   icon,
                              //   height: getProportionateScreenHeight(0),
                              //   color: Colors.white,
                              // ),
                              SizedBox(
                                // color: Colors.red,
                                width: getProportionateScreenWidth(120),
                                child: Text(
                                  "Bob Sightings\nMap",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/eye.svg",
                                height: getProportionateScreenHeight(30),
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.popAndPushNamed(
                      context, HearBobScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, -4),
                          ),
                        ]),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      elevation: 10,
                      margin: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10)),
                          width: SizeConfig.screenWidth / 2,
                          height: getProportionateScreenHeight(75),
                          color: Colors.white,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(
                              //   icon,
                              //   height: getProportionateScreenHeight(0),
                              //   color: Colors.white,
                              // ),
                              SizedBox(
                                // color: Colors.red,
                                width: getProportionateScreenWidth(90),
                                child: Text(
                                  "Hear Bob",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor),
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/music.svg",
                                height: getProportionateScreenHeight(30),
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget buildButtons() {
    if (currentIndex == 0) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
            bottom: getProportionateScreenHeight(10)),
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Next",
                  press: () {
                    setState(() {
                      controller.animateToPage(currentIndex + 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear);
                    });
                  }),
            ),
          ],
        ),
      );
    }
    if (currentIndex == 1) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
            bottom: getProportionateScreenHeight(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Back",
                  press: () {
                    setState(() {
                      controller.animateToPage(currentIndex - 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear);
                    });
                  }),
            ),
            const Spacer(),
            SizedBox(
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Next",
                  press: () {
                    setState(() {
                      controller.animateToPage(currentIndex + 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear);
                    });
                  }),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
            bottom: getProportionateScreenHeight(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.transparent,
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Back",
                  press: () {
                    setState(() {
                      controller.animateToPage(currentIndex - 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear);
                    });
                  }),
            ),
            const Spacer(),
            Container(
              color: Colors.transparent,
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Send",
                  press: () {
                    //TODO inviare i dati all'API
                    context.read<HeardPage3State>().resetAll();
                    context.read<HeardPage1State>().resetAll();
                    context.read<HeardPage2State>().resetAll();

                    Navigator.popAndPushNamed(
                        context, IHeardBobThanksScreen.routeName);
                  }),
            ),
          ],
        ),
      );
    }
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(kPrimaryColor),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(44))),
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
      ),
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(14), color: Colors.white),
      ),
    );
  }
}
