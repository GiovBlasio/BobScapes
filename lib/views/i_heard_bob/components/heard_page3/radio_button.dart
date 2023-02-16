import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/common_widget/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    required this.items,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  final Set<String> items;
  final String title;
  final int id;

  @override
  State<CustomRadioButton> createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  late String group = groupValue(widget.id);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(8),
            bottom: getProportionateScreenHeight(8),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items
                .map(
                  (item) => (item == '1' || item == '2')
                      ? SizedBox(
                          height: getProportionateScreenHeight(45),
                          width: getProportionateScreenWidth(65),
                        )
                      : Column(
                          children: [
                            // Transform.scale(
                            //   scale: getProportionateScreenHeight(1.5),
                            //   child: Radio(
                            //       fillColor:
                            //           const MaterialStatePropertyAll(kColor1),
                            //       overlayColor: const MaterialStatePropertyAll(
                            //           Colors.transparent),
                            //       activeColor: kColor1,
                            //       value: item,
                            //       groupValue: group,
                            //       onChanged: (value) {
                            //         changeValue(widget.id, value!);

                            //         setState(() {
                            //           group = value;
                            //         });
                            //       }),
                            // ),
                            CustomRadio(
                                value: item,
                                groupValue: group,
                                onChanged: (value) {
                                  changeValue(widget.id, value!);
                                  setState(() {
                                    group = value;
                                  });
                                }),
                            Text(
                              item,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      group == item ? kTextColor : kTextColor),
                            ),
                          ],
                        ),
                )
                .toList()),
      ],
    );
  }

  String groupValue(int id) {
    switch (id) {
      case 1:
        return Provider.of<HeardPage3State>(context, listen: false).moreInfo;
      case 2:
        return Provider.of<HeardPage3State>(context, listen: false).learnMore;
      default:
        return 'Yes';
    }
  }

  void changeValue(int id, String value) {
    switch (id) {
      case 1:
        context.read<HeardPage3State>().enablingMoreInformation(value);
        context.read<HeardPage3State>().changeMoreInfoValue(value);
        break;
      case 2:
        context.read<HeardPage3State>().enablingLearnMore(value);
        context.read<HeardPage3State>().changeLearnMoreValue(value);
        break;
    }
  }
}
