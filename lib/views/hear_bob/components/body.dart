import 'package:bobscapes/common_widget/bottom_buttons.dart';
import 'package:bobscapes/common_widget/custom_title.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:flutter/material.dart';

import 'custom_alert.dart';
import 'custom_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          padding:
              const EdgeInsets.only(top: 65, left: 18, right: 18, bottom: 85),
          itemCount: 4,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              showDialog(
                barrierColor: Colors.white.withOpacity(0.9),
                  context: context,
                  builder: (context) => const CustomAlert(
                        title: "Fall covey Call",
                      ));
            },
            child: const CustomCard(
              time: "3:24",
              title: "Male Bobwhite Spring Call",
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 25,
          ),
        ),
        const CustomTitle(title: "Hear Bob"),
        Positioned(
          bottom: 0,
          child: BottomButtons(
            title: "Bob Sightings Map",
            onPress: () => Navigator.popAndPushNamed(
                context, BobSightingsScreen.routeName),
            icon: "assets/icons/eye.svg",
          ),
        ),
      ],
    );
  }
}
