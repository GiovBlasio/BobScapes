import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/common_widget/disclaimer.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late double imageHeight =
      SizeConfig.screenHeight / 2 - getProportionateScreenHeight(45);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            "assets/images/Welcome Background.svg",
            fit: BoxFit.cover,
            // height: SizeConfig.screenHeight -200,
            width: SizeConfig.screenWidth,
          ),
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
        //     ],
        //   )),
        // ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: EdgeInsets.symmetric(
              //       horizontal: getProportionateScreenWidth(20)),
              //   color: Colors.grey,
              //   height: imageHeight,
              //   width: double.infinity,
              // ),
              const Spacer(
                flex: 4,
              ),
              IconButton(
                splashRadius: 0.1,
                padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                onPressed: () => showDialog(
                    useSafeArea: false,
                    context: context,
                    builder: (context) => const Disclaimer()),
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                iconSize: getProportionateScreenHeight(25),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeButton(
                        title: 'Hear Bob',
                        iconPath: "assets/icons/music.svg",
                        color: kColor1,
                        onPressed: () {
                          Navigator.pushNamed(context, HearBobScreen.routeName);
                        },
                      ),
                      HomeButton(
                          title: 'Hey, I heard a Bob!',
                          iconPath: "assets/icons/gps.svg",
                          color: kColor2,
                          onPressed: () => Navigator.pushNamed(
                              context, IHeardBobScreen.routeName)),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// void _showModalBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       context: context,
//       builder: ((context) => DraggableScrollableSheet(
//             //  snap: true,
//             expand: false,
//             initialChildSize: 0.95,
//             //maxChildSize: 0.9,
//             controller: DraggableScrollableController(),
//             builder: ((context, scrollController) => const IHeardBobScreen()),
//           )));
// }

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
        overlayColor: MaterialStateProperty.all(color),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(70))),
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
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SvgPicture.asset(
              iconPath,
              height: getProportionateScreenHeight(35),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
