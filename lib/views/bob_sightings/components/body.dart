import 'package:bobscapes/common_widget/bottom_buttons.dart';
import 'package:bobscapes/common_widget/custom_title.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:flutter/material.dart';

import 'maps.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Mappa(),
        const CustomTitle(title: "Bob Sightings"),
        Positioned(
            bottom: 0,
            child: BottomButtons(
                onPress: () =>
                    Navigator.popAndPushNamed(context, HearBobScreen.routeName),
                icon: "assets/icons/music.svg",
                title: "Hear Bob")),
      ],
    );
  }
}
