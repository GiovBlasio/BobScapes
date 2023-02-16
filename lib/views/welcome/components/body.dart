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
          ? getProportionateScreenWidth(15)
          : getProportionateScreenWidth(15),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(45)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 13,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 28,
                                color: kTextColor,
                                fontWeight: FontWeight.w500),
                            children: const [
                              TextSpan(text: '> Welcome to\n'),
                              TextSpan(
                                  text: 'BOBSCAPES',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor)),
                              TextSpan(
                                text:
                                    ',\na Mobile App to Track\nBobwhite Quail on\nOur Landscapes',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: Text(
                          "We appreciate your\n contribution to conservation!",
                          style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 28,
                                color: kTextColor,
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
                        //       fontWeight: FontWeight.w500,
                        //       color: kTextColor),
                        // ),
                      ),
                     
                      Flexible(
                        flex: 15,
                        child: Text(
                          "Using this app you can\ncontribute to Bobwhite\nconservation efforts by\nreporting Bobwhite that you\nhave heard or spotted in your\n landscape",
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: 20,
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
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      minimumSize: MaterialStateProperty.all(Size(
                          double.infinity, 75)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
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
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: kTextColor),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Flexible(
                            flex: 1,
                            child: SvgPicture.asset(
                              "assets/icons/icon-arrow.svg",
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
