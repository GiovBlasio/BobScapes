import 'package:bobscapes/constants.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Body(),
      ),
    );
  }
}
