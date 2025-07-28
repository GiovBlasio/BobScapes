import 'package:flutter/material.dart';

import 'components/body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Body(),
      ),
    );
  }
}
