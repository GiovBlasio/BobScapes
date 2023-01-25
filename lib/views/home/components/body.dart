import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            // margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.grey,
            height:
                SizeConfig.screenHeight / 2 - getProportionateScreenHeight(45),
            width: double.infinity,
          ),
          IconButton(
              // alignment: Alignment.bottomCenter,
              padding: EdgeInsets.zero,
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.red,
                      height: 10,
                      width: 10,
                    ),
                  ),
              icon: const Icon(Icons.info_outline)),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeButton(
                    title: 'Hear Bob',
                    iconPath: "assets/icons/music.svg",
                    onPressed: () {
                      Navigator.pushNamed(context, HearBobScreen.routeName);
                    },
                  ),
                  HomeButton(
                      title: 'Hey, I heard a Bob!',
                      iconPath: "assets/icons/gps.svg",
                      onPressed: () => showDialog(
                          context: context,
                          builder: ((context) => const IHeardBobScreen())
                          //     _showModalBottomSheet(
                          //           context,
                          )),
                  HomeButton(
                    title: 'Bob Sightings Map',
                    iconPath: "assets/icons/eye.svg",
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
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(kPrimaryColor),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(70))),
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              iconPath,
              height: getProportionateScreenHeight(35),
              color: kPrimaryColor,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white),
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
