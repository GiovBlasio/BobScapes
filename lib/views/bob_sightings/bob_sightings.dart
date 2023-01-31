import 'package:bobscapes/views/common_widget/custom_back_button.dart';
import 'package:bobscapes/views/common_widget/logo.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class BobSightingsScreen extends StatelessWidget {
  const BobSightingsScreen({super.key});

  static String routeName = "/bob_sightings";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColor1,
          leadingWidth: getProportionateScreenWidth(80),
          leading: const CustomBackButton(),
          title: Logo(
            iconColor: Colors.white,
            iconSize: getProportionateScreenWidth(38),
            textSize: getProportionateScreenWidth(19),
            textColor: Colors.white,
          ),
        ),
        body: const Body(),
      ),
    );
  }
}
