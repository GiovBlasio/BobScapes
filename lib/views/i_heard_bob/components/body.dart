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
import 'heard_page1/custom_forms.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/location_form.dart';
import 'heard_page1/personal_info.dart';
import 'heard_page2.dart';
import 'heard_page2/numerical_question.dart';
import 'heard_page2/custom_dropdown_menu.dart' as heard2;
import 'heard_page3.dart';
import 'heard_page3/comment_form.dart';
import 'heard_page3/email_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController controller = PageController();

  int currentIndex = 0;

  bool isLoaded = false;
  final List<String> itemsPage1 = [
    'Landowner',
    'Land manager',
    'Professional (Biologist, Researcher…)',
    'Other'
  ];

  final Set<String> radioOptionsPage1 = {
    'Yes',
    'No',
    'Within a\n half mile',
    'Unsure'
  };

  final Set<String> radioOptions2Page1 = {'Yes', 'No', '1', '2'};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset("assets/images/sfondo3.svg",
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
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom: getProportionateScreenHeight(75),
                                top: getProportionateScreenHeight(15)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: getProportionateScreenWidth(8),
                                      left: getProportionateScreenWidth(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Register your sighting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kTextColor,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    18)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Container(
                                  color: kColor3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Divider(
                                        height: 0,
                                        color: kColor1,
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(20),
                                      ),
                                      const NameForm(),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(20),
                                      ),
                                      CustomDropDownMenu(items: itemsPage1),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(20),
                                      ),
                                      const Divider(
                                        height: 0,
                                        color: kColor1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                const LocationForm(),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                const DateAndTimeForm(),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                const Divider(),
                                CustomRadioButton(
                                    items: radioOptionsPage1,
                                    title:
                                        "Are bobwhites released at the sightings location?",
                                    id: 1),
                                Divider(),
                                CustomRadioButton(
                                    items: radioOptions2Page1,
                                    title: "Did you physically see any birds?",
                                    id: 2),
                                Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(15),
                                    right: getProportionateScreenWidth(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        onPressed: () {
                                          if (!isLoaded) {
                                            setState(() {
                                              controller.animateToPage(
                                                  currentIndex + 1,
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  curve: Curves.linear);
                                            });
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Next",
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          14),
                                                  color: kTextColor),
                                            ),
                                            Icon(
                                              Icons.adaptive.arrow_forward,
                                              color: kTextColor,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Register your sighting",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kTextColor,
                                  fontSize: getProportionateScreenWidth(18)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: const heard2.CustomDropDownMenu(
                            items: ['Family (Covey)', '1', '2', '3']),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15),
                            vertical: getProportionateScreenHeight(15)),
                        child: const NumericalQuestion(
                          title: "How many birds?",
                          id: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15),
                            vertical: getProportionateScreenHeight(15)),
                        child: const NumericalQuestion(
                          title: "How many male?",
                          id: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15),
                            vertical: getProportionateScreenHeight(15)),
                        child: const NumericalQuestion(
                            title: "How many female?", id: 3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15),
                            vertical: getProportionateScreenHeight(15)),
                        child: const NumericalQuestion(
                          title: "How many young birds?",
                          id: 4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15),
                            vertical: getProportionateScreenHeight(15)),
                        child: const NumericalQuestion(
                            title: "How many broods\nrappresented?", id: 5),
                      ),
                      const Spacer(),
                      Container(
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                                        fontSize:
                                            getProportionateScreenWidth(14),
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
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                //      borderRadius: BorderRadius.circular(20))),
                                // minimumSize: MaterialStateProperty.all(Size(
                                //     MediaQuery.of(context).size.width,
                                //     getProportionateScreenHeight(44))),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                                        fontSize:
                                            getProportionateScreenWidth(14),
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
                      ),
                      const Spacer()
                    ],
                  ),
                  Scaffold(
                    resizeToAvoidBottomInset: true,
                    backgroundColor: Colors.transparent,
                    body: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15),
                          vertical: getProportionateScreenHeight(0)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(15),
                                  bottom: getProportionateScreenHeight(80)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Register your sighting",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kTextColor,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    18)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  const CustomRadioButton(
                                      items: {'Yes', 'No', '1', '2'},
                                      title:
                                          "Did you want more information about Bobwhite?",
                                      id: 1),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  const CustomRadioButton(
                                      items: {
                                        'Yes',
                                        'No',
                                        'I\'m alredy\nregistered',
                                        '1'
                                      },
                                      title:
                                          "Want to learn more about Bobwhite Cost Share?",
                                      id: 2),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const EmailForm(),
                                  const CommentForm(),
                                  Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(
                                        // left: getProportionateScreenWidth(15),
                                        // right: getProportionateScreenWidth(15),
                                        top:
                                            getProportionateScreenHeight(20)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            //  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                            //      borderRadius: BorderRadius.circular(20))),
                                            // minimumSize: MaterialStateProperty.all(Size(
                                            //     MediaQuery.of(context).size.width,
                                            //     getProportionateScreenHeight(44))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {
                                            if (!isLoaded) {
                                              setState(() {
                                                controller.animateToPage(
                                                    currentIndex - 1,
                                                    duration: const Duration(
                                                        seconds: 1),
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
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14),
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
                                                  await RemoteService()
                                                      .sendData();
                                                  setState(() {
                                                    context
                                                        .read<HeardPage3State>()
                                                        .resetAll();
                                                    context
                                                        .read<HeardPage1State>()
                                                        .resetAll();
                                                    context
                                                        .read<HeardPage2State>()
                                                        .resetAll();

                                                    Navigator.popAndPushNamed(
                                                        context,
                                                        IHeardBobThanksScreen
                                                            .routeName);
                                                  });
                                                }
                                                //  _changePage();
                                              }),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
        Positioned(
            height: getProportionateScreenHeight(50),
            width: SizeConfig.screenWidth,
            child: const CustomTitle(
              title: "I Heard a Bob!",
              color: kColor2,
              icon: "assets/icons/gps.svg",
            )),
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
        ),
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
        overlayColor: MaterialStateProperty.all(kAppbarColor),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(44))),
        backgroundColor: MaterialStateProperty.all(kAppbarColor),
      ),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                color: kPrimaryColor),
          ),
          Icon(
            Icons.adaptive.arrow_forward,
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}
