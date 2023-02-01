import 'package:bobscapes/views/common_widget/custom_back_button.dart';
import 'package:bobscapes/views/common_widget/logo.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class IHeardBobScreen extends StatelessWidget {
  const IHeardBobScreen({super.key});

  static String routeName = "/i_heard_bob";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kColor2,
          leadingWidth: getProportionateScreenWidth(80),
          leading: const CustomBackButton(),
          title: SvgPicture.asset("assets/images/logo-bobscapes-white.svg"),
        ),
        body: const Body(),
      ),
    );
  }
}
