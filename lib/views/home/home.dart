import 'package:bobscapes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kAppbarColor,
          leading: Container(),
          title: SvgPicture.asset(
            "assets/images/logo-bobscapes.svg",
            height: 34.23,
          ),
        ),
        body: const Body(),
      ),
    );
  }
}
