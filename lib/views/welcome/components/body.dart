import 'dart:ui';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        SvgPicture.asset(
          "assets/images/Welcome Background.svg",
          fit: BoxFit.cover,
          width: SizeConfig.screenWidth,
        ),
        // Container(
        //   height: SizeConfig.screenHeight,
        //   width: SizeConfig.screenWidth,
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       kColor2.withOpacity(0.6),
        //       kColor1.withOpacity(0.6),
        //       kColor1,
        //       kColor1,
        //     ],
        //   )),
        // ),
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
            flex: 3,
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
                      Text(
                        "> Welcome to\nBobwhites on our\nLandscapes.",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            fontWeight: FontWeight.w800,
                            color: kColor3),
                      ),
                      Text(
                        "We appreciate your contribution to conservation!",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ">Observe and Listen",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(25),
                            fontWeight: FontWeight.w800,
                            color: kColor3),
                      ),
                      Text(
                        "Your observation may be included in ongoing research and shared with scientists working to better understand Bobwhite distribution and resiliency on the landscape. Data will not be shared with the public.",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  // const Spacer(
                  //   flex: 1,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(kColor2),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      minimumSize: MaterialStateProperty.all(Size(
                          double.infinity, getProportionateScreenHeight(56))),
                      backgroundColor: MaterialStateProperty.all(kColor2),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          "Enter",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
