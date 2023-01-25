import 'package:bobscapes/common_widget/bottom_buttons.dart';
import 'package:bobscapes/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/hear_bob/components/body.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'maps.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Mappa(),
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
