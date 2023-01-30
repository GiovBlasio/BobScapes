import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../i_heard_bob/i_heard_bob.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    required this.onPress,
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  final Function() onPress;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onPress,
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
                        width: title.contains('Map')
                            ? getProportionateScreenWidth(130)
                            : getProportionateScreenWidth(90),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor),
                        ),
                      ),
                      SvgPicture.asset(
                        icon,
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
    );
  }

  // void _showModalBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       isScrollControlled: true,
  //       context: context,
  //       builder: ((context) => DraggableScrollableSheet(
  //             //  snap: true,
  //             expand: false,
  //             initialChildSize: 0.95,
  //             //maxChildSize: 0.9,
  //             controller: DraggableScrollableController(),
  //             builder: ((context, scrollController) => const IHeardBobScreen()),
  //           )));
  // }
}
