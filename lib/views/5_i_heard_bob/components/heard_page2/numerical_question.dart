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

  late bool isChecked;

  @override
  void initState() {
    isChecked = initialCheck(widget.id);
    super.initState();
  }

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
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                  margin: EdgeInsets.only(left: 50.w, right: 50.w),
                  decoration: const BoxDecoration(
                    color: kColor2,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
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
                    height: 18.h,
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
                          isChecked == true ? changeCheck(widget.id) : null;
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
                        isChecked == true ? changeCheck(widget.id) : null;
                        setState(() {});
                        // // isChecked = initialCheck(widget.id);
                        // setState(() {});
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/icon-plus.svg",
                        width: 13.w,
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // _isSelected = !_isSelected;
                        changeCheck(widget.id);
                        firstAccess(widget.id);
                        isChecked = initialCheck(widget.id);
                        controller.text = initialValue(widget.id);
                      });
                    },
                    child: Row(
                      children: [
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
                          child: initialCheck(widget.id)
                              ? const Icon(
                                  Icons.check,
                                  color: kTextLightColor,
                                )
                              : Container(),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "UNSURE",
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Manrope',
                              fontSize: 14.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                  // CustomCheckBox(
                  //     isChecked: isChecked,
                  //     onPressed: () => changeCheck(widget.id))
                ],
              ),
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
        context.read<HeardPage2State>().changeFirstAccessTotalCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
                .toString();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).totalCheck);

        break;
      case 2:
        context.read<HeardPage2State>().incrementMaleCounter();
        context.read<HeardPage2State>().changeFirstAccessMaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                .toString();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).maleCheck);
        break;
      case 3:
        context.read<HeardPage2State>().incrementFemaleCounter();
        context.read<HeardPage2State>().changeFirstAccessFemaleCounter();

        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
                .toString();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCheck);
        break;
      case 4:
        context.read<HeardPage2State>().incrementYoungCounter();
        context.read<HeardPage2State>().changeFirstAccessYoungCounter();

        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).youngCounter)
                .toString();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).youngCheck);

        break;
      case 5:
        context.read<HeardPage2State>().incrementBroodsCounter();
        context.read<HeardPage2State>().changeFirstAccessBroodsCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCounter)
                .toString();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCheck);
        break;
      default:
    }
    setState(() {});
  }

  void firstAccess(int id) {
    switch (id) {
      case 1:
        if (!Provider.of<HeardPage2State>(context, listen: false).totalCheck) {
          context.read<HeardPage2State>().changeFirstAccessTotalCounter();
          controller.text =
              (Provider.of<HeardPage2State>(context, listen: false)
                      .totalCounter)
                  .toString();
        }

        break;
      case 2:
        if (!Provider.of<HeardPage2State>(context, listen: false).maleCheck) {
          context.read<HeardPage2State>().changeFirstAccessMaleCounter();
          controller.text =
              (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                  .toString();
        }

        break;
      case 3:
        if (!Provider.of<HeardPage2State>(context, listen: false).femaleCheck) {
          context.read<HeardPage2State>().changeFirstAccessFemaleCounter();
          controller.text =
              (Provider.of<HeardPage2State>(context, listen: false)
                      .femaleCounter)
                  .toString();
        }

        break;
      case 4:
        if (!Provider.of<HeardPage2State>(context, listen: false).youngCheck) {
          context.read<HeardPage2State>().changeFirstAccessYoungCounter();
          controller.text =
              (Provider.of<HeardPage2State>(context, listen: false)
                      .youngCounter)
                  .toString();
        }

        break;
      case 5:
        if (!Provider.of<HeardPage2State>(context, listen: false).broodsCheck) {
          context.read<HeardPage2State>().changeFirstAccessBroodsCounter();
          controller.text =
              (Provider.of<HeardPage2State>(context, listen: false)
                      .broodsCounter)
                  .toString();
        }

        break;
      default:
    }
    setState(() {});
  }

  void changeCheck(int id) {
    switch (id) {
      case 1:
        context.read<HeardPage2State>().changeTotalCheck();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).totalCheck);
        //         .toString();
        break;
      case 2:
        context.read<HeardPage2State>().changeMaleCheck();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).maleCheck);
        //         .toString();
        break;
      case 3:
        context.read<HeardPage2State>().changeFemaleCheck();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCheck);
        //         .toString();
        break;
      case 4:
        context.read<HeardPage2State>().changeYoungCheck();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).youngCheck);
        //         .toString();
        break;
      case 5:
        context.read<HeardPage2State>().changeBroodsCheck();
        isChecked =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCheck);

        break;
      default:
    }
  }

  String initialValue(int id) {
    switch (id) {
      case 1:
        {
          if ((!Provider.of<HeardPage2State>(context, listen: false)
              .totalCheck)) {
            return (Provider.of<HeardPage2State>(context, listen: false)
                    .totalCounter)
                .toString();
          } else {
            return 'Null';
          }
        }
      case 2:
        {
          if ((!Provider.of<HeardPage2State>(context, listen: false)
              .maleCheck)) {
            return (Provider.of<HeardPage2State>(context, listen: false)
                    .maleCounter)
                .toString();
          } else {
            return 'Null';
          }
        }

      case 3:
        {
          if ((!Provider.of<HeardPage2State>(context, listen: false)
              .femaleCheck)) {
            return (Provider.of<HeardPage2State>(context, listen: false)
                    .femaleCounter)
                .toString();
          } else {
            return 'Null';
          }
        }

      case 4:
        {
          if ((!Provider.of<HeardPage2State>(context, listen: false)
              .youngCheck)) {
            return (Provider.of<HeardPage2State>(context, listen: false)
                    .youngCounter)
                .toString();
          } else {
            return 'Null';
          }
        }
      case 5:
        {
          if ((!Provider.of<HeardPage2State>(context, listen: false)
              .broodsCheck)) {
            return (Provider.of<HeardPage2State>(context, listen: false)
                    .broodsCounter)
                .toString();
          } else {
            return 'Null';
          }
        }
      default:
        return 'Null';
    }
  }

  bool initialCheck(int id) {
    switch (id) {
      case 1:
        return Provider.of<HeardPage2State>(context, listen: false).totalCheck;
      case 2:
        return Provider.of<HeardPage2State>(context, listen: false).maleCheck;
      case 3:
        return Provider.of<HeardPage2State>(context, listen: false).femaleCheck;
      case 4:
        return Provider.of<HeardPage2State>(context, listen: false).youngCheck;
      case 5:
        return Provider.of<HeardPage2State>(context, listen: false).broodsCheck;
      default:
        return false;
    }
  }
}
