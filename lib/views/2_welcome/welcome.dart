import 'package:bobscapes/views/2_welcome/components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static String routeName = "/welcome";

  @override
  State<WelcomeScreen> createState() => _BodyState();
}

class _BodyState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
