import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/i_heard_bob/components/body.dart';
import 'package:flutter/material.dart';

import 'heard_page2/custom_dropdown_menu.dart';
import 'heard_page2/numerical_question.dart';

class HeardPage2 extends StatelessWidget {
  const HeardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15), vertical: 0),
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

          const CustomDropDownMenu(items: ['Family', '1', '2', '3']),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: NumericalQuestion(
              title: "How many birds?",
              id: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: NumericalQuestion(
              title: "How many male?",
              id: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: NumericalQuestion(title: "How many female?", id: 3),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: NumericalQuestion(
              title: "How many young birds?",
              id: 4,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: NumericalQuestion(
                title: "How many broods rappresented?", id: 5),
          ),
          //DefaultButton(text: "Prossimo", press: () {}),
        ],
      ),
    );
  }
}
