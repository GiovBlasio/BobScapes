import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/email_enabler.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/i_heard_bob/components/heard_page3.dart';
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
              top: getProportionateScreenHeight(5),
              left: getProportionateScreenWidth(15),
              right: getProportionateScreenWidth(10)),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(13),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
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
                            Transform.scale(
                              scale: 1.3,
                              child: Radio(
                                  activeColor: kPrimaryColor,
                                  value: item,
                                  groupValue: group,
                                  onChanged: (value) {
                                    changeValue(widget.id, value!);

                                    setState(() {
                                      group = value;
                                    });
                                  }),
                            ),
                            SizedBox(
                                height: getProportionateScreenHeight(37),
                                width: getProportionateScreenWidth(65),
                                child: Text(
                                  item,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(13),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
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
        return Provider.of<EmailEnabler>(context, listen: false).moreInfo;
      case 2:
        return Provider.of<EmailEnabler>(context, listen: false).learnMore;
      default:
        return 'Yes';
    }
  }

  void changeValue(int id, String value) {
    switch (id) {
      case 1:
        context.read<EmailEnabler>().enablingMoreInformation(value);
        context.read<EmailEnabler>().changeMoreInfoValue(value);
        break;
      case 2:
        context.read<EmailEnabler>().enablingLearnMore(value);
        context.read<EmailEnabler>().changeLearnMoreValue(value);
        break;
    }
  }
}
