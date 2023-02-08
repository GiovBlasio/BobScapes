import 'package:bobscapes/services/remote_services.dart';
import 'package:bobscapes/views/common_widget/bottom_buttons.dart';
import 'package:bobscapes/views/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/models/audio.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_alert.dart';
import 'custom_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Audio> audio = [
    Audio(
        time: "4",
        title: "Male Bobwhite Spring Call",
        path: "male-bobwhite-spring-call.mp3",
        pathImage: "assets/images/bobwhite.jpg"),
    Audio(
        time: "6",
        title: "Fall covey Call",
        path: "fall-covey-call.mp3",
        pathImage: "assets/images/covata.jpg")
  ];

  bool isLoaded = true;
  @override
  void initState() {
    super.initState();
    _initialization();
  }

  _initialization() async {
    //audio = await RemoteService().getAudio();
    // if (audio.isNotEmpty) {
    //   setState(() {
    //     isLoaded = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset("assets/images/sfondo3.svg",
              fit: BoxFit.cover,
              // height: SizeConfig.screenHeight,
              width: double.infinity),
        ),
        Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(60),
                left: getProportionateScreenWidth(18),
                right: getProportionateScreenWidth(18),
                bottom: getProportionateScreenHeight(80)),
            itemCount: audio.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                showDialog(
                    barrierColor: Colors.white.withOpacity(0.7),
                    context: context,
                    builder: (context) => CustomAlert(
                          title: audio[index].title,
                          path: audio[index].path,
                        ));
              },
              child: CustomCard(
                time: audio[index].time,
                title: audio[index].title,
                path: audio[index].pathImage,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: getProportionateScreenHeight(25),
            ),
          ),
        ),
        const CustomTitle(
          title: "Hear Bob",
          color: kColor1,
          icon: "assets/icons/music.svg",
        ),
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
                color: kColor2,
                title: "Hey, I heard Bob!",
                iconPath: "assets/icons/gps.svg",
                onPressed: () => Navigator.popAndPushNamed(
                    context, IHeardBobScreen.routeName),
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
              //   onTap: () {
              //     Navigator.popAndPushNamed(context, IHeardBobScreen.routeName);
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.teal,
              //         borderRadius: BorderRadius.circular(12),
              //         boxShadow: const [
              //           BoxShadow(
              //             color: Colors.black12,
              //             spreadRadius: 4,
              //             blurRadius: 4,
              //             offset: Offset(0, -4), // Shadow position
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
              //           color: kColor2,
              //           child: Row(
              //             children: [
              //               const Spacer(
              //                 flex: 2,
              //               ),
              //               Text(
              //                 "Hey, I heard Bob!",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontSize: getProportionateScreenWidth(14),
              //                     fontWeight: FontWeight.w500,
              //                     color: Colors.white),
              //               ),
              //               const Spacer(),
              //               SvgPicture.asset(
              //                 "assets/icons/gps.svg",
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
              // )
            ],
          ),
        ),
      ],
    );
  }
}
