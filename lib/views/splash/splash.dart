import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Body(),
      ),
    );
  }
}
