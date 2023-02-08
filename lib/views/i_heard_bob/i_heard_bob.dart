import 'package:bobscapes/views/common_widget/custom_back_button.dart';
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: kAppbarColor,
            leadingWidth: getProportionateScreenWidth(80),
            leading: const CustomBackButton(),
            title: SvgPicture.asset(
              "assets/images/logo-bobscapes.svg",
              height: getProportionateScreenWidth(30),
            ),
          ),
          body: const Body(),
        ),
      ),
    );
  }
}
