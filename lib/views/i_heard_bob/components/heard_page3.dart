import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'heard_page3/comment_form.dart';
import 'heard_page3/email_form.dart';
import 'heard_page3/radio_button.dart';

class HeardPage3 extends StatelessWidget {
  const HeardPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(15), bottom: 120),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Register your sighting",
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                color: kTextColor,
                                fontSize: 18.sp),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomRadioButton(
                          items: {'Yes', 'No', '1', '2'},
                          title:
                              "Did you want more information about Bobwhite?",
                          id: 1),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomRadioButton(
                          items: {'Yes', 'No', 'I\'m alredy\nregistered', '1'},
                          title:
                              "Want to learn more about Bobwhite Cost Share?",
                          id: 2),
                      const SizedBox(
                        height: 15,
                      ),
                      const EmailForm(),
                      const CommentForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
