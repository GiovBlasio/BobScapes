import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/common_widget/logo.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: kColor1,
          leading: Container(),
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
