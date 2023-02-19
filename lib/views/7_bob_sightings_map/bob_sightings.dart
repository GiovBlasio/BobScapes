import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../common_widget/custom_back_button.dart';
import '../common_widget/title_back.dart';
import 'components/body.dart';

class BobSightingsScreen extends StatelessWidget {
  const BobSightingsScreen({super.key});

  static String routeName = "/bob_sightings";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kAppbarColor,
            leadingWidth: 80.w,
            leading: const CustomBackButton(),
            title: const TitleBack()),
        body: const Body(),
      ),
    );
  }
}
