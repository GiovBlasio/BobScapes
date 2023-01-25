import 'package:flutter/material.dart';

import 'components/body.dart';

class IHeardBobScreen extends StatelessWidget {
  const IHeardBobScreen({super.key});

  static String routeName = "/i_heard_bob";

  @override
  Widget build(BuildContext context) {
    // return const Scaffold(
    //   backgroundColor: Colors.transparent,
    //   body: Body(),
    // );
     return const Body();
  }
}
