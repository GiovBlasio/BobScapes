import 'package:bobscapes/common_widget/custom_back_button.dart';
import 'package:bobscapes/common_widget/logo.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class IHeardBobScreen extends StatelessWidget {
  const IHeardBobScreen({super.key});

  static String routeName = "/i_heard_bob";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: getProportionateScreenWidth(80),
        leading: const CustomBackButton(),
        title: Logo(
          iconColor: kPrimaryColor,
          iconSize: getProportionateScreenWidth(38),
          textSize: getProportionateScreenWidth(19),
          textColor: kPrimaryColor,
        ),
      ),
      body: const Body(),
    );
  }
}
