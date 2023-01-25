import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/page_changer.dart';
//import 'body.dart';
import 'body.dart';
import 'heard_page1/custom_forms.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/personal_info.dart';
import 'heard_page2.dart';
import 'heard_page3.dart';

class HeardPage1 extends StatefulWidget {
  const HeardPage1({
    Key? key,
  }) : super(key: key);

  @override
  State<HeardPage1> createState() => _HeardPage1State();
}

class _HeardPage1State extends State<HeardPage1> {
  final List<String> items = ['Landowner', '1', '2', '3'];

  final Set<String> radioOptions = {
    'Yes',
    'No',
    'Within a half mile',
    'Unsure'
  };

  final Set<String> radioOptions2 = {'Yes', 'No', '1', '2'};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Register your sighting".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(14)),
                ),
                IconButton(
                  splashRadius: 0.1,
                  icon: Icon(
                    Icons.close,
                    size: getProportionateScreenHeight(28),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalInfo(items: items),
                  const LocationForm(),
                  const DateAndTimeForm(),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(6.25))),
                  CustomRadioButton(
                      items: radioOptions,
                      title:
                          "Are bobwhites released at the sightings location?",
                      id: 1),
                  CustomRadioButton(
                      items: radioOptions2,
                      title: "Did you physically see any birds?",
                      id: 2),
                  //   Padding(
                  //     padding:
                  //         const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  //     child: DefaultButton(
                  //         text: "Next",
                  //         press: () {
                  //           // changePage(HeardPage1());

                  //           // setState(() {
                  //           //   // page = Provider.of<PageChanger>(context,
                  //           //   //         listen: false)
                  //           //   //     .page;
                  //           //   // top = Provider.of<PageChanger>(context,
                  //           //   //         listen: false)
                  //           //   //     .top;
                  //           // });

                  //          // Navigator.of(context).pop();
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => HeardPage2()));
                  //           // setState(() {

                  //           //   page = page.runtimeType == HeardPage1
                  //           //       ? HeardPage2()
                  //           //       : HeardPage3();
                  //           //   top = page.runtimeType == HeardPage2
                  //           //       ? getProportionateScreenHeight(235)
                  //           //       : getProportionateScreenHeight(150);
                  //           // });
                  //         }),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changePage(Widget newPage) {
    switch (newPage.runtimeType) {
      case HeardPage1:
        context.read<PageChanger>().changePage(HeardPage2());
        context
            .read<PageChanger>()
            .changeTop(getProportionateScreenHeight(235));
        break;
      case HeardPage2:
        context.read<PageChanger>().changePage(HeardPage3());
        context
            .read<PageChanger>()
            .changeTop(getProportionateScreenHeight(150));
        break;
      case HeardPage3:
        context.read<PageChanger>().changePage(HeardPage1());
        context.read<PageChanger>().changeTop(getProportionateScreenHeight(60));
        break;
      default:
    }
  }
}
