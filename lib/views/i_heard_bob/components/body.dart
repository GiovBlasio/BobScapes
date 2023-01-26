import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'heard_page1.dart';
import 'heard_page2.dart';
import 'heard_page3.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget page = const HeardPage1();
  //double top = getProportionateScreenHeight(60);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          curve: Curves.linearToEaseOut,
          bottom: 0,
          left: 0,
          //top: top,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(5)),
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
                    //width: SizeConfig.screenWidth / 2,
                    // height: 75,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Flexible(child: page), buildButtons()],
                    )),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildButtons() {
    if (page.runtimeType == HeardPage1) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
            bottom: getProportionateScreenHeight(10)),
        child: DefaultButton(
            text: "Next",
            press: () {
              setState(() {
                page = const HeardPage2();
                // page = page.runtimeType == HeardPage1
                //     ? HeardPage2()
                //     : HeardPage3();
                // top = getProportionateScreenHeight(285);
                // top = page.runtimeType == HeardPage2
                //     ? getProportionateScreenHeight(235)
                //     : getProportionateScreenHeight(150);
              });
            }),
      );
    }
    if (page.runtimeType == HeardPage2) {
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
            SizedBox(
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Back",
                  press: () {
                    setState(() {
                      page = const HeardPage1();
                      // page = page.runtimeType == HeardPage1
                      //     ? HeardPage2()
                      //     : HeardPage3();
                      //     top = getProportionateScreenHeight(60);
                      // top = page.runtimeType == HeardPage2
                      //  F   ? getProportionateScreenHeight(235)
                      //     : getProportionateScreenHeight(150);
                    });
                  }),
            ),
            const Spacer(),
            SizedBox(
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Next",
                  press: () {
                    setState(() {
                      page = const HeardPage3();
                      // page = page.runtimeType == HeardPage1
                      //     ? HeardPage2()
                      //     : HeardPage3();
                      //   top = getProportionateScreenHeight(180);
                      // top = page.runtimeType == HeardPage2
                      //     ? getProportionateScreenHeight(235)
                      //     : getProportionateScreenHeight(150);
                    });
                  }),
            ),
          ],
        ),
      );
    }
    // if (page.runtimeType == HeardPage3) {
    else {
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
            Container(
              color: Colors.transparent,
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Back",
                  press: () {
                    setState(() {
                      page = const HeardPage2();
                      // page = page.runtimeType == HeardPage1
                      //     ? HeardPage2()
                      //     : HeardPage3();
                      //    top = getProportionateScreenHeight(285);
                      // top = page.runtimeType == HeardPage2
                      //     ? getProportionateScreenHeight(235)
                      //     : getProportionateScreenHeight(150);
                    });
                  }),
            ),
            const Spacer(),
            Container(
              color: Colors.transparent,
              width: (SizeConfig.screenWidth) / 2 -
                  getProportionateScreenWidth(30),
              child: DefaultButton(
                  text: "Send",
                  press: () {
                    //TODO inviare i dati all'API
                    context.read<HeardPage3State>().resetAll();
                    context.read<HeardPage1State>().resetAll();
                    context.read<HeardPage2State>().resetAll();

                    Navigator.popAndPushNamed(
                        context, IHeardBobThanksScreen.routeName);
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
        overlayColor: MaterialStateProperty.all(kPrimaryColor),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(56))),
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        // padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(18), color: Colors.white),
      ),
    );
  }
}
