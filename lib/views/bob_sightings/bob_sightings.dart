import 'package:bobscapes/views/common_widget/custom_back_button.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class BobSightingsScreen extends StatelessWidget {
  const BobSightingsScreen({super.key});

  static String routeName = "/bob_sightings";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppbarColor,
          leadingWidth: getProportionateScreenWidth(80),
          leading: const CustomBackButton(),
          title: TitleBack()
        ),
        body: const Body(),
      ),
    );
  }
}
