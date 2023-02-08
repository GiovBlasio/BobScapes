import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/page_changer.dart';

import 'heard_page1/custom_forms.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/location_form.dart';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(90),
                        top: getProportionateScreenHeight(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: getProportionateScreenWidth(8),
                              left: getProportionateScreenWidth(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Register your sighting",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kTextColor,
                                    fontSize: getProportionateScreenWidth(18)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Container(
                          color: kColor3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Divider(
                                height: 0,
                                color: kColor1,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              const NameForm(),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              CustomDropDownMenu(items: items),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              const Divider(
                                height: 0,
                                color: kColor1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        const LocationForm(),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        const DateAndTimeForm(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        const Divider(),
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
    );
  }
}
