import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
  String page = 'Welcome';

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 8),
      height: 2.1.h,
      width: currentIndex == index ? 2.1.h : 2.1.h,
      decoration: BoxDecoration(
          color: currentIndex == index ? kTextColor : kTextLightColor,
          shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/sfondo2.svg",
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth,
          ),
        ),
        Positioned(
          top: 5.h,
          width: 100.w,
          child: SvgPicture.asset(
            "assets/images/logo-bobscapes.svg",
            width: 45,
            height: 45,
          ),
        ),

        Positioned(
          top: 25.h,
          bottom: 0.h,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40.h,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 9.w, right: 9.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: kTextColor,
                                  fontFamily: 'Manrope',
                                 // fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(text: '> Welcome to\n'),
                                TextSpan(
                                    text: 'BOBSCAPES',
                                    style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor)),
                                TextSpan(
                                  text:
                                      ',\nA Mobile App to\nTrack Bobwhite Quail On Our Landscapes',
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "We appreciate your\ncontribution to conservation!",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: kTextColor,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500),
                              children: const [
                                TextSpan(
                                  text: "> Spotting Bob",
                                ),

                                // TextSpan(
                                //   text:
                                //       "Using this app you can\ncontribute to Bobwhite\nconservation efforts by\nreporting Bobwhite that you\nhave heard or spotted in your\n landscape",

                                // ),
                              ],
                            ),
                          ),
                          Text(
                            "Using this app you can contribute to Bobwhite conservation efforts by reporting Bobwhite that you have heard or seen in your landscape",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 16.sp,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => buildDot(index: index),
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 28.h,
        //   left: 10.w,
        //   right: 10.w,
        //   //top: 80.h,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: List.generate(
        //       2,
        //       (index) => buildDot(index: index),
        //     ),
        //   ),
        // ),
        if (currentIndex == 1)
          Positioned(
            right: 5.w,
            left: 5.w,
            bottom: 10.sp,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.white),
                shadowColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 75)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () =>
                  Navigator.popAndPushNamed(context, HomeScreen.routeName),
              child: Row(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Enter",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        color: kTextColor),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Flexible(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/icons/union.svg",
                        height: 20,
                      )),
                ],
              ),
            ),
          ),

        // SizedBox(
        //   width: double.infinity,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       const Spacer(),
        //       SvgPicture.asset(
        //         "assets/images/logo-bobscapes.svg",
        //         width: 45,
        //         height: 45,
        //       ),
        //       const Spacer(
        //         flex: 2,
        //       ),
        //       Flexible(
        //         flex: 5,
        //         child: PageView(
        //           onPageChanged: (value) {
        //             setState(() {
        //               currentIndex = value;
        //             });
        //           },
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.only(
        //                   left: getProportionateScreenWidth(57),
        //                   right: getProportionateScreenWidth(47)),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Flexible(
        //                     flex: 13,
        //                     child: RichText(
        //                       text: TextSpan(
        //                         style: TextStyle(
        //                             fontSize: 28.sp,
        //                             color: kTextColor,
        //                             fontFamily: 'Manrope', fontWeight: FontWeight.w500),
        //                         children: const [
        //                           TextSpan(text: '> Welcome to\n'),
        //                           TextSpan(
        //                               text: 'BOBSCAPES',
        //                               style: TextStyle(
        //                                   fontFamily: 'Manrope', fontWeight: FontWeight.w700,
        //                                   color: kPrimaryColor)),
        //                           TextSpan(
        //                             text:
        //                                 ',\na Mobile App to Track Bobwhite Quail on Our Landscapes',
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                   const Spacer(),
        //                   Flexible(
        //                     flex: 3,
        //                     child: Text(
        //                       "We appreciate your contribution to conservation!",
        //                       style: TextStyle(
        //                           fontSize: 20.sp,
        //                           fontFamily: 'Manrope', fontWeight: FontWeight.w500,
        //                           color: kTextColor),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Padding(
        //               padding: EdgeInsets.symmetric(
        //                   horizontal: getProportionateScreenWidth(45)),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Flexible(
        //                     flex: 3,
        //                     child: RichText(
        //                       text: TextSpan(
        //                         style: TextStyle(
        //                             fontSize: 28.sp,
        //                             color: kTextColor,
        //                             fontFamily: 'Manrope', fontWeight: FontWeight.w500),
        //                         children: const [
        //                           TextSpan(
        //                             text: "> Spotting Bob\n",
        //                           ),

        //                           // TextSpan(
        //                           //   text:
        //                           //       "Using this app you can\ncontribute to Bobwhite\nconservation efforts by\nreporting Bobwhite that you\nhave heard or spotted in your\n landscape",

        //                           // ),
        //                         ],
        //                       ),
        //                     ),
        //                     // Text(
        //                     //   ">Spotting Bob",
        //                     //   style: TextStyle(
        //                     //       fontSize: getProportionateScreenWidth(26),
        //                     //       fontFamily: 'Manrope', fontWeight: FontWeight.w500,
        //                     //       color: kTextColor),
        //                     // ),
        //                   ),

        //                   Flexible(
        //                     flex: 15,
        //                     child: Text(
        //                       "Using this app you can contribute to Bobwhite conservation efforts by reporting Bobwhite that you have heard or seen in your landscape",
        //                       style: TextStyle(
        //                           color: kTextColor,
        //                           fontSize: 20.sp,
        //                           fontFamily: 'Manrope', fontWeight: FontWeight.w500),
        //                     ),
        //                   ),
        //                   // Spacer()
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Flexible(
        //         flex: 3,
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(
        //               horizontal: getProportionateScreenWidth(20)),
        //           child: Column(
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: List.generate(
        //                   2,
        //                   (index) => buildDot(index: index),
        //                 ),
        //               ),
        //               const Spacer(
        //                 flex: 3,
        //               ),
        //               if (currentIndex == 1)
        //                 TextButton(
        //                   style: ButtonStyle(
        //                     overlayColor:
        //                         MaterialStateProperty.all(Colors.white),
        //                     shadowColor: MaterialStateProperty.all(Colors.grey),
        //                     shape: MaterialStateProperty.all(
        //                         RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(12))),
        //                     minimumSize: MaterialStateProperty.all(
        //                         Size(double.infinity, 75)),
        //                     backgroundColor:
        //                         MaterialStateProperty.all(Colors.white),
        //                   ),
        //                   onPressed: () => Navigator.popAndPushNamed(
        //                       context, HomeScreen.routeName),
        //                   child: Row(
        //                     children: [
        //                       const Spacer(
        //                         flex: 3,
        //                       ),
        //                       Text(
        //                         "Enter",
        //                         style: TextStyle(
        //                             fontSize: 24.sp,
        //                             fontFamily: 'Manrope', fontWeight: FontWeight.w600,
        //                             color: kTextColor),
        //                       ),
        //                       const Spacer(
        //                         flex: 2,
        //                       ),
        //                       Flexible(
        //                           flex: 1,
        //                           child: SvgPicture.asset(
        //                             "assets/icons/union.svg",
        //                             height: 20,
        //                           )),
        //                     ],
        //                   ),
        //                 ),
        //               const Spacer()
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }

  SizedBox buildContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          SvgPicture.asset(
            "assets/images/logo-bobscapes.svg",
            width: 45,
            height: 45,
          ),
          const Spacer(
            flex: 2,
          ),
          Flexible(
            flex: 5,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(57),
                      right: getProportionateScreenWidth(47)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 13,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: kTextColor,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500),
                            children: const [
                              TextSpan(text: '> Welcome to\n'),
                              TextSpan(
                                  text: 'BOBSCAPES',
                                  style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor)),
                              TextSpan(
                                text:
                                    ',\na Mobile App to Track Bobwhite Quail on Our Landscapes',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: Text(
                          "We appreciate your contribution to conservation!",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                              color: kTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(45)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 28.sp,
                                color: kTextColor,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500),
                            children: const [
                              TextSpan(
                                text: "> Spotting Bob\n",
                              ),

                              // TextSpan(
                              //   text:
                              //       "Using this app you can\ncontribute to Bobwhite\nconservation efforts by\nreporting Bobwhite that you\nhave heard or spotted in your\n landscape",

                              // ),
                            ],
                          ),
                        ),
                        // Text(
                        //   ">Spotting Bob",
                        //   style: TextStyle(
                        //       fontSize: getProportionateScreenWidth(26),
                        //       fontFamily: 'Manrope', fontWeight: FontWeight.w500,
                        //       color: kTextColor),
                        // ),
                      ),

                      Flexible(
                        flex: 15,
                        child: Text(
                          "Using this app you can contribute to Bobwhite conservation efforts by reporting Bobwhite that you have heard or seen in your landscape",
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 20.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  if (currentIndex == 1)
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white),
                        shadowColor: MaterialStateProperty.all(Colors.grey),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        minimumSize: MaterialStateProperty.all(
                            Size(double.infinity, 75)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () => Navigator.popAndPushNamed(
                          context, HomeScreen.routeName),
                      child: Row(
                        children: [
                          const Spacer(
                            flex: 3,
                          ),
                          Text(
                            "Enter",
                            style: TextStyle(
                                fontSize: 24.sp,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                color: kTextColor),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Flexible(
                              flex: 1,
                              child: SvgPicture.asset(
                                "assets/icons/union.svg",
                                height: 20,
                              )),
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
