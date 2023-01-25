import 'package:bobscapes/constants.dart';

import '../../size_config.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
