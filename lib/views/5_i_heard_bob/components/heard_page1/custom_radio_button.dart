import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page1_state.dart';
import '../../../../provider/heard_page/heard_page2_state.dart';
import '../../../common_widget/custom_radio.dart';

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
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  late String group = groupValue(widget.id);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: kTextLightColor,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: widget.title,
              ),
              if (widget.id == 1)
                TextSpan(
                    text: ' (required)',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                    )),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items
                .map(
                  (item) => (item == '1' || item == '2')
                      ? SizedBox(
                          height: 45.h,
                          width: 65.w,
                        )
                      : InkWell(
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          onTap: () {
                            changeValue(widget.id, item);
                            setState(
                              () {
                                group = item;
                              },
                            );
                          },
                          child: Column(
                            children: [
                              CustomRadio(
                                value: item,
                                groupValue: group,
                                onChanged: (value) {
                                  changeValue(widget.id, value!);

                                  setState(() {
                                    group = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                item,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w700,
                                  color: kTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                )
                .toList()),
      ],
    );
  }

  String groupValue(int id) {
    switch (id) {
      case 1:
        return Provider.of<HeardPage1State>(context, listen: false)
            .releasedIntoLocation;
      case 2:
        return Provider.of<HeardPage1State>(context, listen: false)
            .physicallySee;
      default:
        return 'Yes';
    }
  }

  void changeValue(int id, String value) {
    switch (id) {
      case 1:
        context.read<HeardPage1State>().changeReleasedLocation(value);
        break;
      case 2:
        context.read<HeardPage1State>().changePhysicallySee(value);
        if (value == 'No') {
          context.read<HeardPage2State>().resetAll();
        }
        break;
    }
  }
}
