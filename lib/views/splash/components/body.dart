import 'dart:async';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/common_widget/logo_animated.dart';
import 'package:bobscapes/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../welcome/welcome.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool animate = false;
  bool opacity = false;

  late double bottomLogo = getProportionateScreenHeight(405);
  late double leftLogo = getProportionateScreenWidth(28);
  late double bottomTextRow = getProportionateScreenHeight(-100);
  late double bottomBackground = getProportionateScreenHeight(0);
  late double imageWidth = SizeConfig.screenWidth;
  late double logoHeight = getProportionateScreenHeight(95);
  late double logoWidth = getProportionateScreenWidth(45);
  late double leftFirstPin = getProportionateScreenWidth(-50);
  late double bottomMainPhrase = getProportionateScreenHeight(-200);
  late double rightSecondPin = getProportionateScreenWidth(-60);

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      SizeConfig().init(context);
    });

    setState(() {
      opacity = true;
      bottomLogo = getProportionateScreenHeight(380);
      bottomTextRow = getProportionateScreenHeight(30);
      bottomBackground = getProportionateScreenHeight(100);
    });

    await Future.delayed(const Duration(milliseconds: 5000));

    setState(() {
      animate = true;
      bottomLogo = getProportionateScreenHeight(360);
      leftLogo = getProportionateScreenWidth(22);
      imageWidth = imageWidth + 100;
      logoHeight = getProportionateScreenHeight(85);
      logoWidth = getProportionateScreenWidth(40);
      leftFirstPin = getProportionateScreenWidth(-17);
      bottomMainPhrase = getProportionateScreenHeight(180);
      rightSecondPin = getProportionateScreenWidth(10);
    });

    await Future.delayed(
        const Duration(milliseconds: 5000),
        () => Navigator.of(context)
          ..pushReplacement(
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const WelcomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1, 0);
                const end = Offset.zero;
                const curve = Curves.slowMiddle;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: animate ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: SvgPicture.asset(
            "assets/images/sfondo1.svg",
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth,
          ),
        ),
        AnimatedOpacity(
          opacity: animate ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: SvgPicture.asset(
            "assets/images/sfondo-welcome2.svg",
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth,
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(seconds: 1),
            bottom: bottomLogo,
            left: leftLogo,
            child: AnimatedOpacity(
              opacity: opacity ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: AnimatedLogo(
                  logoHeight: logoHeight,
                  logoWidth: logoWidth,
                  duration: const Duration(seconds: 1)),
            )),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          left: getProportionateScreenHeight(25),
          bottom: bottomMainPhrase,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bobwhites",
                style: TextStyle(
                    height: 1,
                    fontSize: getProportionateScreenWidth(44),
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "on our",
                style: TextStyle(
                  height: 1,
                  fontSize: getProportionateScreenWidth(44),
                  color: kPrimaryColor,
                ),
              ),
              Text(
                "landscapes",
                style: TextStyle(
                  height: 1,
                  fontSize: getProportionateScreenWidth(44),
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(seconds: 1),
            bottom: bottomTextRow,
            left: getProportionateScreenHeight(0),
            right: getProportionateScreenHeight(0),
            child: AnimatedOpacity(
              opacity: opacity ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: Row(
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/images/wlfw.svg",
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  SvgPicture.asset(
                    "assets/images/quail-forever.svg",
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    "assets/images/gamelabmartin.png",
                    //height: 90,
                    scale: 3,
                  ),
                  const Spacer()
                ],
              ),
            ))
      ],
    );
  }
}

class Transition extends StatelessWidget {
  const Transition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1, 0);
                const end = Offset.zero;
                const curve = Curves.slowMiddle;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              }),
        );
      }),
    );
  }
}
