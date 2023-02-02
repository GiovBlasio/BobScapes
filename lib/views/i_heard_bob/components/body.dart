import 'package:bobscapes/services/remote_services.dart';
import 'package:bobscapes/views/common_widget/bottom_buttons.dart';
import 'package:bobscapes/views/common_widget/custom_title.dart';
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

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset("assets/images/Welcome Background.svg",
              fit: BoxFit.cover, width: double.infinity),
        ),
        Positioned(
            bottom: getProportionateScreenHeight(0),
            top: getProportionateScreenHeight(50),
            left: 0,
            right: 0,
            child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                controller: controller,
                children: const [HeardPage1(), HeardPage2(), HeardPage3()])),
        Positioned(
            height: getProportionateScreenHeight(50),
            width: SizeConfig.screenWidth,
            child: const CustomTitle(
              title: "I Heard a Bob!",
              color: kColor2,
              icon: "assets/icons/gps.svg",
            )),
        Positioned(
            bottom: getProportionateScreenHeight(70),
            right: 0,
            left: 0,
            child: buildButtons()),
        Positioned(
            bottom: 0,
            child: Row(
              children: [
                BottomButton(
                  color: kColor3,
                  title: "Bob Sightings Map",
                  iconPath: "assets/icons/eye.svg",
                  onPressed: () => Navigator.popAndPushNamed(
                      context, BobSightingsScreen.routeName),
                ),
                BottomButton(
                  color: kColor1,
                  title: "Hear Bob",
                  iconPath: "assets/icons/music.svg",
                  onPressed: () => Navigator.popAndPushNamed(
                      context, HearBobScreen.routeName),
                ),
                // InkWell(
                //   onTap: () => Navigator.popAndPushNamed(
                //       context, BobSightingsScreen.routeName),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         boxShadow: const [
                //           BoxShadow(
                //             color: Colors.black12,
                //             spreadRadius: 4,
                //             blurRadius: 4,
                //             offset: Offset(0, -4),
                //           ),
                //         ]),
                //     child: Card(
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //       ),
                //       elevation: 10,
                //       margin: const EdgeInsets.all(0),
                //       child: ClipRRect(
                //         borderRadius: const BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //         child: Container(
                //           padding: EdgeInsets.symmetric(
                //               vertical: getProportionateScreenHeight(10)),
                //           width: SizeConfig.screenWidth / 2,
                //           height: getProportionateScreenHeight(63),
                //           color: kColor3,
                //           child: Row(
                //             children: [
                //               const Spacer(
                //                 flex: 2,
                //               ),
                //               Text(
                //                 "Bob Sightings Map",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     fontSize: getProportionateScreenWidth(14),
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.white),
                //               ),
                //               const Spacer(),
                //               SvgPicture.asset(
                //                 "assets/icons/eye.svg",
                //                 height: getProportionateScreenHeight(25),
                //                 color: Colors.white,
                //               ),
                //               const Spacer()
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // InkWell(
                //   onTap: () => Navigator.popAndPushNamed(
                //       context, HearBobScreen.routeName),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(12),
                //         boxShadow: const [
                //           BoxShadow(
                //             color: Colors.black12,
                //             spreadRadius: 4,
                //             blurRadius: 4,
                //             offset: Offset(0, -4),
                //           ),
                //         ]),
                //     child: Card(
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //       ),
                //       elevation: 10,
                //       margin: const EdgeInsets.all(0),
                //       child: ClipRRect(
                //         borderRadius: const BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //         child: Container(
                //           padding: EdgeInsets.symmetric(
                //               vertical: getProportionateScreenHeight(10)),
                //           width: SizeConfig.screenWidth / 2,
                //           height: getProportionateScreenHeight(63),
                //           color: kColor1,
                //           child: Row(
                //             children: [
                //               const Spacer(
                //                 flex: 2,
                //               ),
                //               Text(
                //                 "Hear Bob",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     fontSize: getProportionateScreenWidth(14),
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.white),
                //               ),
                //               const Spacer(),
                //               SvgPicture.asset(
                //                 "assets/icons/music.svg",
                //                 height: getProportionateScreenHeight(25),
                //                 color: Colors.white,
                //               ),
                //               const Spacer()
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )),
        if (isLoaded)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kColor2),
              backgroundColor: kColor1,
            ),
          )
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(20))),
                // minimumSize: MaterialStateProperty.all(Size(
                //     MediaQuery.of(context).size.width,
                //     getProportionateScreenHeight(44))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                if (!isLoaded) {
                  setState(() {
                    controller.animateToPage(currentIndex + 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black),
                  ),
                  Icon(
                    Icons.adaptive.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
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
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(20))),
                // minimumSize: MaterialStateProperty.all(Size(
                //     MediaQuery.of(context).size.width,
                //     getProportionateScreenHeight(44))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                if (!isLoaded) {
                  setState(() {
                    controller.animateToPage(currentIndex - 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  });
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.adaptive.arrow_back,
                    color: Colors.black,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black),
                  ),
                  // Icon(
                  //   Icons.adaptive.arrow_back,
                  //   color: Colors.black,
                  // )
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(20))),
                // minimumSize: MaterialStateProperty.all(Size(
                //     MediaQuery.of(context).size.width,
                //     getProportionateScreenHeight(44))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                if (!isLoaded) {
                  setState(() {
                    controller.animateToPage(currentIndex + 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  });
                }
              },
              child: Row(
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black),
                  ),
                  Icon(
                    Icons.adaptive.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
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
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(20))),
                // minimumSize: MaterialStateProperty.all(Size(
                //     MediaQuery.of(context).size.width,
                //     getProportionateScreenHeight(44))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                if (!isLoaded) {
                  setState(() {
                    controller.animateToPage(currentIndex - 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.linear);
                  });
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.adaptive.arrow_back,
                    color: Colors.black,
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              color: Colors.transparent,
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Send data",
                  press: () async {
                    if (!isLoaded) {
                      setState(() {
                        isLoaded = !isLoaded;
                      });
                      await RemoteService().sendData();
                      setState(() {
                        context.read<HeardPage3State>().resetAll();
                        context.read<HeardPage1State>().resetAll();
                        context.read<HeardPage2State>().resetAll();

                        Navigator.popAndPushNamed(
                            context, IHeardBobThanksScreen.routeName);
                      });
                    }
                    //  _changePage();
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
        overlayColor: MaterialStateProperty.all(kColor2),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(44))),
        backgroundColor: MaterialStateProperty.all(kColor2),
      ),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(13), color: Colors.white),
          ),
          Icon(
            Icons.adaptive.arrow_forward,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
