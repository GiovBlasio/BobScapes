import 'dart:async';
import 'dart:ui';

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
  late double logoHeight = getProportionateScreenWidth(95);
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
    await Future.delayed(const Duration(milliseconds: 2000));

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
      logoHeight = getProportionateScreenWidth(85);
      logoWidth = getProportionateScreenWidth(40);
      leftFirstPin = getProportionateScreenWidth(-17);
      bottomMainPhrase = getProportionateScreenHeight(180);
      rightSecondPin = getProportionateScreenWidth(10);
    });

    await Future.delayed(
      const Duration(milliseconds: 5000),
      () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1, 0);
            const end = Offset.zero;
            const curve = Curves.slowMiddle;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        // // AnimatedPositioned(
        //   duration: const Duration(seconds: 1),
        //   bottom: bottomBackground,
        //   child: AnimatedOpacity(
        //     opacity: opacity ? 1 : 0,
        //     duration: const Duration(seconds: 1),
        //     child: AnimatedContainer(
        //       duration: const Duration(seconds: 1),
        //       width: imageWidth,
        //       child: Image.asset(
        //         "assets/images/Bob Scapes Background.jpg",
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned.fill(
        //    child: BackdropFilter(
        //   filter: ImageFilter.blur(
        //     sigmaX: 20,
        //     sigmaY: 20,
        //   ),
        //   child: const SizedBox(),
        // )),
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
        // AnimatedPositioned(
        //     duration: const Duration(seconds: 1),
        //     top: getProportionateScreenHeight(290),
        //     left: leftFirstPin,
        //     child: SvgPicture.asset(
        //       "assets/icons/pin.svg",
        //       height: getProportionateScreenHeight(45),
        //       color: Colors.white,
        //     )),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "on our",
                style: TextStyle(
                  height: 1,
                  fontSize: getProportionateScreenWidth(44),
                  color: Colors.white,
                ),
              ),
              Text(
                "landscapes",
                style: TextStyle(
                  height: 1,
                  fontSize: getProportionateScreenWidth(44),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // AnimatedPositioned(
        //     duration: const Duration(seconds: 1),
        //     top: animate
        //         ? getProportionateScreenHeight(545)
        //         : getProportionateScreenHeight(500),
        //     right: rightSecondPin,
        //     child: SvgPicture.asset(
        //       "assets/icons/pin.svg",
        //       height: getProportionateScreenHeight(70),
        //       color: Colors.white,
        //     )),
        AnimatedPositioned(
            duration: const Duration(seconds: 1),
            bottom: bottomTextRow,
            left: getProportionateScreenHeight(0),
            right: getProportionateScreenHeight(0),
            child: AnimatedOpacity(
              opacity: opacity ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/logo-quail.png",
                    //height: 90,
                    scale: 1.5,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  SvgPicture.asset(
                    "assets/images/logo-landscape.svg",
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    "assets/images/wlfw-logo.png",
                    //height: 70,

                    scale: 2,
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
