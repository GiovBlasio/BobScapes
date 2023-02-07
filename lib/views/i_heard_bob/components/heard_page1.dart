import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/page_changer.dart';

import 'heard_page1/custom_forms.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/personal_info.dart';
// import 'heard_page2.dart';
// import 'heard_page3.dart';

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
    'Within a\n half mile',
    'Unsure'
  };

  final Set<String> radioOptions2 = {'Yes', 'No', '1', '2'};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,

        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(8),
            //vertical: getProportionateScreenHeight(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 90, top: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Register your sighting".toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          getProportionateScreenWidth(14)),
                                ),
                                // IconButton(
                                //   splashRadius: 0.1,
                                //   icon: Icon(
                                //     Icons.close,
                                //     size: getProportionateScreenHeight(28),
                                //   ),
                                //   onPressed: () {
                                //     Navigator.pop(context);
                                //   },
                                // )
                              ],
                            ),
                          ),
                          Divider(
                            color: kColor1,
                          ),
                          NameForm(),
                          CustomDropDownMenu(items: items),
                          Divider(
                            color: kColor1,
                          ),
                          LocationForm(),
                          DateAndTimeForm(),
                          Divider(),
                          CustomRadioButton(
                              items: radioOptions,
                              title:
                                  "Are bobwhites released at the sightings location?",
                              id: 1),
                          Divider(),
                          CustomRadioButton(
                              items: radioOptions2,
                              title: "Did you physically see any birds?",
                              id: 2),
                        ],
                      ))),
              //   Flexible(
              //     child: SingleChildScrollView(
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              // PersonalInfo(items: items),
              //           const LocationForm(),
              //           const DateAndTimeForm(),
              //           Padding(
              //               padding: EdgeInsets.symmetric(
              //                   vertical: getProportionateScreenWidth(2))),
              //           CustomRadioButton(
              //               items: radioOptions,
              //               title:
              //                   "Are bobwhites released at the sightings location?",
              //               id: 1),
              //           CustomRadioButton(
              //               items: radioOptions2,
              //               title: "Did you physically see any birds?",
              //               id: 2),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
