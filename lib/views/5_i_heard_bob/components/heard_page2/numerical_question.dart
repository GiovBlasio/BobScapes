import 'package:bobscapes/views/common_widget/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page2_state.dart';

class NumericalQuestion extends StatefulWidget {
  const NumericalQuestion({
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  final String title;
  final int id;

  @override
  State<NumericalQuestion> createState() => _NumericalQuestionState();
}

class _NumericalQuestionState extends State<NumericalQuestion> {
  late TextEditingController controller =
      TextEditingController(text: initialValue(widget.id));

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  color: kTextColor),
            ),
            if (widget.id == 5)
              Container(
                padding: EdgeInsets.only(left: 5.w),
                child: Tooltip(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
                  margin: EdgeInsets.only(left: 50.w, right: 50.w),
                  decoration: const BoxDecoration(
                    color: kColor2,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  showDuration: const Duration(seconds: 25),
                  triggerMode: TooltipTriggerMode.tap,
                  verticalOffset: -5.h,
                  preferBelow: false,
                  textStyle: TextStyle(
                      color: kTextColor,
                      fontSize: 12.sp,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500),
                  message:
                      'During the summer months, female will join up, resulting in mixed age groups of young.\nYour answer should reflect how many age groups you see.',
                  child: SvgPicture.asset(
                    "assets/icons/icon-info.svg",
                    height: 18,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kColor3,
                      border: Border.all(color: kTextColor, width: 0.4),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(3.5))),
                  width: 35.h,
                  height: 35.h,
                  child: IconButton(
                      splashRadius: 0.1,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          decrementCounter(widget.id);
                        });
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/icon-minus.svg",
                        width: 13.w,
                      )),
                ),
                SizedBox(
                  width: 60.w,
                  child: TextFormField(
                    contextMenuBuilder: (context, editableTextState) {
                      return Container();
                    },
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16.sp,
                      fontFamily: 'Manrope',
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                    enableInteractiveSelection: false,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: controller,
                    readOnly: true,
                    decoration: const InputDecoration.collapsed(hintText: ""),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kColor3,
                    border: Border.all(color: kTextColor, width: 0.4),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(3.5),
                    ),
                  ),
                  width: 35.h,
                  height: 35.h,
                  child: IconButton(
                      splashRadius: 0.1,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        incrementCounter(widget.id);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/icon-plus.svg",
                        width: 13.w,
                      )),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCheckBox(
                  isChecked: false,
                  //  // groupValue: groupValue,
                  //   value: checkValue,
                  //   onChanged: (value) => setState(() {
                  //     checkValue = value!;
                  //   }),
                )
                // Checkbox(
                //   value: checkValue,
                //   onChanged: (value) => setState(() {
                //     checkValue = value!;
                //   }),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: kColor3,
                //       border: Border.all(color: kTextColor, width: 0.4),
                //       borderRadius:
                //           const BorderRadius.all(Radius.circular(3.5))),
                //   width: 35.h,
                //   height: 35.h,
                //   child: IconButton(
                //       splashRadius: 0.1,
                //       padding: EdgeInsets.zero,
                //       onPressed: () {
                //         setState(() {
                //           decrementCounter(widget.id);
                //         });
                //       },
                //       icon: SvgPicture.asset(
                //         "assets/icons/icon-minus.svg",
                //         width: 13.w,
                //       )),
                // ),
              ],
            ),
          ],
        )
      ],
    );
  }

  void decrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<HeardPage2State>().decrementTotalCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<HeardPage2State>().decrementMaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<HeardPage2State>().decrementFemaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<HeardPage2State>().decrementYoungCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).youngCounter)
                .toString();
        break;

      case 5:
        context.read<HeardPage2State>().decrementBroodsCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  void incrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<HeardPage2State>().incrementTotalCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<HeardPage2State>().incrementMaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<HeardPage2State>().incrementFemaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<HeardPage2State>().incrementYoungCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).youngCounter)
                .toString();
        break;
      case 5:
        context.read<HeardPage2State>().incrementBroodsCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  String initialValue(int id) {
    switch (id) {
      case 1:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .totalCounter)
            .toString();
      case 2:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .maleCounter)
            .toString();
      case 3:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .femaleCounter)
            .toString();
      case 4:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .youngCounter)
            .toString();
      case 5:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .broodsCounter)
            .toString();
      default:
        return '0';
    }
  }
}
