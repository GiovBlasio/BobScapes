import 'dart:async';

import 'package:bobscapes/common_widget/logo_animated.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_row.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool animate = false;

  @override
  void initState() {
    super.initState();

    startAnimation();

    Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
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
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: animate ? getProportionateScreenHeight(130) : 0,
            left: animate ? getProportionateScreenHeight(30) : 0,
            child: AnimatedLogo(
                iconColor: Colors.white,
                iconSize: animate
                    ? 75 //getProportionateScreenWidth(85)
                    : 65, //getProportionateScreenWidth(75),
                textSize: animate
                    ? 35 //getProportionateScreenWidth(35)
                    : 33, //getProportionateScreenWidth(33),
                textColor: const Color(0xbbffffff),
                duration: const Duration(seconds: 1))),
        Positioned(
            top: getProportionateScreenHeight(320),
            left: getProportionateScreenHeight(-17),
            // right: getProportionateScreenWidth(5),
            child: SvgPicture.asset(
              "assets/icons/pin.svg",
              height: getProportionateScreenHeight(45),
              color: Colors.white,
            )),
        Positioned(
          top: getProportionateScreenHeight(390),
          left: getProportionateScreenHeight(25),
          // right: getProportionateScreenWidth(5),
          child: Text(
            "BOBWHITE",
            style: TextStyle(
                height: 1,
                fontSize: getProportionateScreenWidth(45),
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ),
        Positioned(
          top: getProportionateScreenHeight(440),
          left: getProportionateScreenHeight(25),
          // right: getProportionateScreenWidth(5),
          child: Text(
            "IN OUR",
            style: TextStyle(
                height: 1,
                fontSize: getProportionateScreenWidth(45),
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ),
        Positioned(
          top: getProportionateScreenHeight(490),
          left: getProportionateScreenHeight(25),
          // right: getProportionateScreenWidth(5),
          child: Text(
            "LANDSCAPES",
            style: TextStyle(
                height: 1,
                fontSize: getProportionateScreenWidth(45),
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ),
        Positioned(
            top: getProportionateScreenHeight(545),
            right: getProportionateScreenHeight(10),
            // right: getProportionateScreenWidth(5),
            child: SvgPicture.asset(
              "assets/icons/pin.svg",
              height: getProportionateScreenWidth(70),
              color: Colors.white,
            )),
        const BottomRow()
      ],
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });

    await Future.delayed(const Duration(milliseconds: 2000));
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
