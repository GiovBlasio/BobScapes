import 'package:bobscapes/constants.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class IHeardBobThanksScreen extends StatelessWidget {
  const IHeardBobThanksScreen({super.key});

  static String routeName = "/i_heard_bob_thanks";

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
