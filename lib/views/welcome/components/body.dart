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
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? kPrimaryColor : const Color(0xffd8d8d8),
        borderRadius: BorderRadius.circular(3),
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
        buildContent(context),
      ],
    );
  }

  SizedBox buildContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Opacity(
            opacity: 0,
            child: Image.asset(
              "assets/images/Bob Scapes Background.jpg",
            ),
          ),
          Expanded(
            flex: 1,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              children: [
                Column(
                  children: const [
                    Spacer(),
                    Text(
                      "Got It!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "> Welcome to Bobwhites on our Landscapes.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "We appreciate your contribution to conservation!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Spacer()
                  ],
                ),
                Column(
                  children: const [
                    Spacer(),
                    Text(
                      ">Observe and Listen",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Your observation may be included in ongoing research and shared with scientists working to better understand Bobwhite distribution and resiliency on the landscape. Data will not be shared with the public.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  const Spacer(),
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
