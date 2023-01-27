import 'package:bobscapes/common_widget/bottom_buttons.dart';
import 'package:bobscapes/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'maps.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Mappa(),
        const CustomTitle(title: "Bob Sightings Map"),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              InkWell(
                onTap: () =>
                    Navigator.popAndPushNamed(context, HearBobScreen.routeName),
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
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, IHeardBobScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, -4), // Shadow position
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
                            SvgPicture.asset(
                              "assets/icons/gps.svg",
                              height: getProportionateScreenHeight(30),
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(110),
                              child: Text(
                                "Hey, I heard Bob!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor),
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/icons/gps.svg",
                              height: getProportionateScreenHeight(30),
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
       
      ],
    );
  }
}
