import 'package:flutter/material.dart';

import '../../constants.dart';
import '../common_widget/title_back.dart';
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
          title: const TitleBack(),
        ),
        body: const Body(),
      ),
    );
  }
}
