import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'heard_page2/custom_dropdown_menu.dart';
import 'heard_page2/numerical_question.dart';

class HeardPage2 extends StatelessWidget {
  const HeardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          const CustomDropDownMenu(items: ['Family (Covey)', '1', '2', '3']),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15)),
            child: const NumericalQuestion(
              title: "How many birds?",
              id: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15)),
            child: const NumericalQuestion(
              title: "How many male?",
              id: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15)),
            child: const NumericalQuestion(title: "How many female?", id: 3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15)),
            child: const NumericalQuestion(
              title: "How many young birds?",
              id: 4,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15)),
            child: const NumericalQuestion(
                title: "How many broods represented?", id: 5),
          ),
        ],
      ),
    );
  }
}
