import 'dart:async';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/home_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  bool isDisclaimer = false;

  bool discalimerClosed = false;
  bool showQuail = true;

  late Timer timer;

  void changeFirstAccess() {
    context.read<HomeState>().changeFirstAccess();
  }

  @override
  Widget build(BuildContext context) {
    discalimerClosed = false;
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/sfondo2.svg",
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth,
          ),
        ),
        if (showQuail && !isDisclaimer)
          Positioned(
            bottom: 245,
            left: 40,
            right: 20,
            child: Image.asset(
              "assets/images/quail.png",
              height: 200,
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      splashRadius: 0.1,
                      padding: const EdgeInsets.only(left: 15),
                      onPressed: () {
                        setState(() {
                          isDisclaimer = !isDisclaimer;
                        });
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/icon-info.svg",
                        height: 23,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      HomeButton(
                        title: 'Hear Bob',
                        iconPath: "assets/icons/music.svg",
                        color: kColor1,
                        onPressed: () {
                          Navigator.pushNamed(context, HearBobScreen.routeName);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      HomeButton(
                          title: 'Hey, I heard a Bob!',
                          iconPath: "assets/icons/gps.svg",
                          color: kColor2,
                          onPressed: () {
                            setState(() {
                              showQuail = false;
                            });
                            if (Provider.of<HomeState>(context, listen: false)
                                .firstAccess) {
                              changeFirstAccess();
                              showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) =>
                                      _showDisclaimer(context));

                              timer = Timer(const Duration(seconds: 25), () {
                                setState(() {
                                  showQuail = true;
                                });
                                if (!discalimerClosed) {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, IHeardBobScreen.routeName);
                                }
                              });
                            } else {
                              setState(() {
                                showQuail = true;
                              });

                              Navigator.pushNamed(
                                  context, IHeardBobScreen.routeName);
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      HomeButton(
                        title: 'Bob Sightings Map',
                        iconPath: "assets/icons/eye.svg",
                        color: kColor3,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, BobSightingsScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isDisclaimer)
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                Positioned(
                  bottom: 400,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/quail-reflected.png",
                    height: 200,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Positioned(
                  height: 453,
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(0)),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15)),
                        decoration: const BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(30),
                                    right: getProportionateScreenWidth(10)),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    const Text(
                                      "Disclaimer",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    IconButton(
                                      splashRadius: 0.1,
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: kTextColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isDisclaimer = !isDisclaimer;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(30),
                                      top: 30,
                                      bottom: 5,
                                      right: getProportionateScreenWidth(40)),
                                  child: Text(
                                    "The exact location of your sightings will not be shared with the public.",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            getProportionateScreenWidth(14.5)),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(30),
                                      top: 20,
                                      bottom: 5,
                                      right: getProportionateScreenWidth(40)),
                                  child: const Text(
                                    "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.5),
                                  )),
                            ],
                          ),
                        )),
                  ),
                ),
              ]))
      ],
    );
  }

  Stack _showDisclaimer(BuildContext context) {
    return Stack(children: [
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Positioned(
              bottom: 400,
              left: 0,
              right: 20,
              child: Image.asset(
                "assets/images/quail-reflected.png",
                height: 200,
                alignment: Alignment.centerLeft,
              ),
            ),
            Positioned(
              height: 525 - 72,
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                elevation: 10,
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(0)),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(15)),
                    decoration: const BoxDecoration(
                        color: kColor3,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(30),
                                right: getProportionateScreenWidth(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Text(
                                  "Disclaimer",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                IconButton(
                                  splashRadius: 0.1,
                                  icon: const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: kTextColor,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, IHeardBobScreen.routeName);
                                    setState(() {
                                      timer.cancel();
                                    });
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    setState(() {
                                      showQuail = true;

                                      discalimerClosed = true;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 30,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: Text(
                                "The exact location of your sightings will not be shared with the public.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        getProportionateScreenWidth(14.5)),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 20,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: const Text(
                                "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5),
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ])),
    ]);
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    required this.title,
    required this.iconPath,
    required this.onPressed,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(8),
        overlayColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 75)),
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              iconPath,
              height: getProportionateScreenHeight(35),
              color: color,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: kTextColor,
                  fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset(
              iconPath,
              height: getProportionateScreenHeight(35),
              color: kTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
