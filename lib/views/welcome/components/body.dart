import 'dart:ui';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/home/home.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: getProportionateScreenHeight(15),
      width: currentIndex == index
          ? getProportionateScreenWidth(45)
          : getProportionateScreenWidth(15),
      decoration: BoxDecoration(
        color: kColor3,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/images/Bob Scapes Background.jpg",
            fit: BoxFit.fill,
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
          ),
        ),
        Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kColor2.withOpacity(0.6),
              kColor1.withOpacity(0.6),
              kColor1,
              kColor1,
            ],
          )),
        ),
        buildContent(context),
      ],
    );
  }

  SizedBox buildContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(
            flex: 4,
          ),
          Flexible(
            flex: 2,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Got It!",
                      //   // textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 14, fontWeight: FontWeight.w500),
                      // ),
                      Text(
                        "> Welcome to\nBobwhites on our\nLandscapes.",
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            fontWeight: FontWeight.w800,
                            color: kColor3),
                      ),
                      Text(
                        "We appreciate your contribution to conservation!",
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      // Spacer()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Spacer(),
                      Text(
                        ">Observe and Listen",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            fontWeight: FontWeight.w800,
                            color: kColor3),
                      ),
                      Text(
                        "Your observation may be included in ongoing research and shared with scientists working to better understand Bobwhite distribution and resiliency on the landscape. Data will not be shared with the public.",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w500),
                      ),
                      //     Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Spacer(
          //   flex: 1,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     2,
          //     (index) => buildDot(index: index),
          //   ),
          // ),
          //   Spacer(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                   TextButton(
                     style: ButtonStyle(
                       overlayColor: MaterialStateProperty.all(kPrimaryColor),
                       shadowColor: MaterialStateProperty.all(Colors.grey),
                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(20))),
                       minimumSize: MaterialStateProperty.all(Size(
                           double.infinity, getProportionateScreenHeight(56))),
                       backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                     ),
                     onPressed: () =>
                         Navigator.pushNamed(context, HomeScreen.routeName),
                     child: Text(
                       "Continue",
                       style: TextStyle(
                           fontSize: getProportionateScreenWidth(14),
                           color: Colors.white),
                     ),
                   ),
                  //  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
