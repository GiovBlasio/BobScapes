import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page2_state.dart';

class Counters extends StatefulWidget {
  const Counters({
    super.key,
  });

  @override
  State<Counters> createState() => _CountersState();
}

class _CountersState extends State<Counters> {
  late TextEditingController controllerFirst = TextEditingController();
  late bool isCheckedFirst;
  late int valueFirst;

  late TextEditingController controllerSecond = TextEditingController();
  late int valueSecond;
  late bool isCheckedSecond;

  late TextEditingController controllerThird = TextEditingController();
  late int valueThird;
  late bool isCheckedThird;

  @override
  void initState() {
    isCheckedFirst = initialCheck(1);
    valueFirst =
        (Provider.of<HeardPage2State>(context, listen: false).totalCounter);
    controllerFirst.text = initialValue(1);

    isCheckedSecond = initialCheck(2);
    valueSecond =
        (Provider.of<HeardPage2State>(context, listen: false).maleCounter);
    controllerSecond.text = initialValue(2);

    isCheckedThird = initialCheck(3);
    valueThird =
        (Provider.of<HeardPage2State>(context, listen: false).femaleCounter);
    controllerThird.text = initialValue(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "How many adult birds?",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        color: kTextColor),
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
                          color: valueFirst > 0 &&
                                  valueFirst > valueSecond + valueThird
                              ? kColor3
                              : const Color(0XFFF2F2F2),
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
                              setState(() {
                                if (valueFirst > 0 &&
                                    valueFirst > valueSecond + valueThird) {
                                  valueFirst = valueFirst - 1;
                                }

                                controllerFirst.text = valueFirst.toString();
                                context
                                    .read<HeardPage2State>()
                                    .decrementTotalCounter();

                                if (isCheckedFirst) {
                                  isCheckedFirst = !isCheckedFirst;
                                  context
                                      .read<HeardPage2State>()
                                      .changeTotalCheck();
                                }
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
                            fontWeight: FontWeight.w700,
                          ),
                          enableInteractiveSelection: false,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: controllerFirst,
                          readOnly: true,
                          decoration:
                              const InputDecoration.collapsed(hintText: ""),
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
                              setState(() {
                                valueFirst = valueFirst + 1;
                                controllerFirst.text = "$valueFirst";
                                context
                                    .read<HeardPage2State>()
                                    .incrementTotalCounter();
                                if (isCheckedFirst) {
                                  context
                                      .read<HeardPage2State>()
                                      .changeTotalCheck();

                                  isCheckedFirst = !isCheckedFirst;
                                }
                              });
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
                              isCheckedFirst = !isCheckedFirst;
                              context
                                  .read<HeardPage2State>()
                                  .changeTotalCheck();

                              if (isCheckedFirst) {
                                controllerFirst.text = '';
                                controllerSecond.text = '';
                                controllerThird.text = '';
                                if (!isCheckedSecond) {
                                  context
                                      .read<HeardPage2State>()
                                      .changeMaleCheck();
                                }
                                if (!isCheckedThird) {
                                  context
                                      .read<HeardPage2State>()
                                      .changeFemaleCheck();
                                }
                                isCheckedSecond = true;
                                isCheckedThird = true;
                              } else {
                                controllerFirst.text = valueFirst.toString();
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: kColor3,
                                  border:
                                      Border.all(color: kTextColor, width: 0.4),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3.5),
                                  ),
                                ),
                                width: 35.h,
                                height: 35.h,
                                child: isCheckedFirst
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
                      ],
                    ),
                  ),
                ],
              ),
              // Text('$isCheckedFirst')
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        const Divider(),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "How many adult male?",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        color: kTextColor),
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
                          color: valueSecond > 0
                              ? kColor3
                              : const Color(0xFFF2F2F2),
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
                            setState(
                              () {
                                if (valueSecond > 0) {
                                  valueSecond = valueSecond - 1;

                                  controllerSecond.text =
                                      valueSecond.toString();
                                  context
                                      .read<HeardPage2State>()
                                      .decrementMaleCounter();

                                  if (isCheckedSecond) {
                                    isCheckedSecond = !isCheckedSecond;
                                    context
                                        .read<HeardPage2State>()
                                        .changeMaleCheck();
                                    if (isCheckedFirst) {
                                      isCheckedFirst = !isCheckedFirst;
                                      context
                                          .read<HeardPage2State>()
                                          .changeTotalCheck();
                                    }
                                  }
                                }
                              },
                            );
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/icon-minus.svg",
                            width: 13.w,
                          ),
                        ),
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
                            fontWeight: FontWeight.w700,
                          ),
                          enableInteractiveSelection: false,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: controllerSecond,
                          readOnly: true,
                          decoration:
                              const InputDecoration.collapsed(hintText: ""),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: valueSecond + valueThird < valueFirst
                              ? kColor3
                              : const Color(0XFFF2F2F2),
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
                              setState(() {
                                if (valueSecond + valueThird < valueFirst) {
                                  valueSecond = valueSecond + 1;
                                  context
                                      .read<HeardPage2State>()
                                      .incrementMaleCounter();

                                  controllerSecond.text =
                                      valueSecond.toString();

                                  if ((valueSecond == valueFirst ||
                                          valueFirst ==
                                              valueSecond + valueThird) &&
                                      isCheckedThird) {
                                    if (valueSecond == valueFirst) {
                                      for (int i = valueThird; i > 0; i--) {
                                        context
                                            .read<HeardPage2State>()
                                            .decrementFemaleCounter();
                                      }
                                      valueThird = 0;
                                    }
                                    controllerThird.text =
                                        valueThird.toString();

                                    context
                                        .read<HeardPage2State>()
                                        .changeFemaleCheckToFalse();

                                    isCheckedThird = false;
                                  }
                                  if (isCheckedSecond) {
                                    isCheckedSecond = !isCheckedSecond;
                                    context
                                        .read<HeardPage2State>()
                                        .changeMaleCheck();
                                    if (isCheckedFirst) {
                                      isCheckedFirst = !isCheckedFirst;
                                      context
                                          .read<HeardPage2State>()
                                          .changeTotalCheck();
                                    }
                                  }
                                }
                              });
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
                              isCheckedSecond = !isCheckedSecond;
                              context.read<HeardPage2State>().changeMaleCheck();

                              if (!isCheckedSecond) {
                                controllerSecond.text = valueSecond.toString();
                                if (isCheckedFirst) {
                                  context
                                      .read<HeardPage2State>()
                                      .changeTotalCheck();
                                  isCheckedFirst = false;

                                  controllerFirst.text = valueFirst.toString();
                                }
                              } else {
                                controllerSecond.text = '';
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: kColor3,
                                  border:
                                      Border.all(color: kTextColor, width: 0.4),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3.5),
                                  ),
                                ),
                                width: 35.h,
                                height: 35.h,
                                child: isCheckedSecond
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
                      ],
                    ),
                  ),
                ],
              ),
              // Text('$isCheckedSecond')
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        const Divider(),
        SizedBox(
          height: 15.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "How many adult female?",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          color: kTextColor),
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
                              color: valueThird > 0
                                  ? kColor3
                                  : const Color(0XFFF2F2F2),
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
                                  if (valueThird > 0) {
                                    valueThird = valueThird - 1;

                                    context
                                        .read<HeardPage2State>()
                                        .decrementFemaleCounter();
                                    controllerThird.text =
                                        valueThird.toString();
                                    if (isCheckedThird) {
                                      context
                                          .read<HeardPage2State>()
                                          .changeFemaleCheck();
                                      isCheckedThird = !isCheckedThird;
                                      if (isCheckedFirst) {
                                        context
                                            .read<HeardPage2State>()
                                            .changeTotalCheck();
                                        isCheckedFirst = !isCheckedFirst;
                                      }
                                    }
                                  }
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
                              fontWeight: FontWeight.w700,
                            ),
                            enableInteractiveSelection: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: controllerThird,
                            readOnly: true,
                            decoration:
                                const InputDecoration.collapsed(hintText: ""),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: valueSecond + valueThird < valueFirst
                                ? kColor3
                                : const Color(0XFFF2F2F2),
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
                                setState(() {
                                  if (valueSecond + valueThird < valueFirst) {
                                    valueThird = valueThird + 1;
                                    context
                                        .read<HeardPage2State>()
                                        .incrementFemaleCounter();

                                    controllerThird.text =
                                        valueThird.toString();
                                    if ((valueThird == valueFirst ||
                                            valueFirst ==
                                                valueSecond + valueThird) &&
                                        isCheckedSecond) {
                                      if (valueThird == valueFirst) {
                                        for (int i = valueSecond; i > 0; i--) {
                                          context
                                              .read<HeardPage2State>()
                                              .decrementMaleCounter();
                                        }
                                        valueSecond = 0;
                                      }
                                      controllerSecond.text =
                                          valueSecond.toString();
                                      isCheckedSecond = false;
                                      context
                                          .read<HeardPage2State>()
                                          .changeMaleCheckToFalse();
                                      // context
                                      //     .read<HeardPage2State>()
                                      //     .changeMaleCheck();
                                    }
                                    if (isCheckedThird) {
                                      isCheckedThird = !isCheckedThird;
                                      context
                                          .read<HeardPage2State>()
                                          .changeFemaleCheck();
                                      if (isCheckedFirst) {
                                        context
                                            .read<HeardPage2State>()
                                            .changeTotalCheck();
                                        isCheckedFirst = !isCheckedFirst;
                                      }
                                    }
                                  }
                                });
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
                                isCheckedThird = !isCheckedThird;
                                context
                                    .read<HeardPage2State>()
                                    .changeFemaleCheck();

                                if (!isCheckedThird) {
                                  if (isCheckedFirst) {
                                    context
                                        .read<HeardPage2State>()
                                        .changeTotalCheck();
                                    isCheckedFirst = false;
                                  }
                                  controllerThird.text = valueThird.toString();
                                  controllerFirst.text = valueFirst.toString();
                                } else {
                                  controllerThird.text = '';
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: kColor3,
                                    border: Border.all(
                                        color: kTextColor, width: 0.4),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(3.5),
                                    ),
                                  ),
                                  width: 35.h,
                                  height: 35.h,
                                  child: isCheckedThird
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
                        ],
                      ),
                    ),
                  ],
                ),
                // Text('$isCheckedThird')
              ],
            )),
      ],
    );
  }

  // void decrementCounter(int id) {
  //   switch (id) {
  //     case 1:
  //       context.read<HeardPage2State>().decrementTotalCounter();
  //       controllerFirst.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
  //               .toString();
  //       break;
  //     case 2:
  //       context.read<HeardPage2State>().decrementMaleCounter();
  //       controllerSecond.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
  //               .toString();
  //       break;
  //     case 3:
  //       context.read<HeardPage2State>().decrementFemaleCounter();
  //       controllerThird.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
  //               .toString();
  //       break;
  //     default:
  //   }
  // }

  // void incrementCounter(int id) {
  //   switch (id) {
  //     case 1:
  //       context.read<HeardPage2State>().incrementTotalCounter();
  //       context.read<HeardPage2State>().changeFirstAccessTotalCounter();
  //       controllerFirst.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
  //               .toString();
  //       isCheckedFirst =
  //           (Provider.of<HeardPage2State>(context, listen: false).totalCheck);
  //       break;
  //     case 2:
  //       context.read<HeardPage2State>().incrementMaleCounter();
  //       context.read<HeardPage2State>().changeFirstAccessMaleCounter();
  //       controllerSecond.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
  //               .toString();
  //       isCheckedSecond =
  //           (Provider.of<HeardPage2State>(context, listen: false).maleCheck);
  //       break;
  //     case 3:
  //       context.read<HeardPage2State>().incrementFemaleCounter();
  //       context.read<HeardPage2State>().changeFirstAccessFemaleCounter();
  //       controllerThird.text =
  //           (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
  //               .toString();
  //       isCheckedThird =
  //           (Provider.of<HeardPage2State>(context, listen: false).femaleCheck);
  //       break;
  //     default:
  //   }
  //   setState(() {});
  // }

  // void firstAccess(int id) {
  //   switch (id) {
  //     case 1:
  //       if (!Provider.of<HeardPage2State>(context, listen: false).totalCheck) {
  //         context.read<HeardPage2State>().changeFirstAccessTotalCounter();
  //         controllerFirst.text =
  //             (Provider.of<HeardPage2State>(context, listen: false)
  //                     .totalCounter)
  //                 .toString();
  //       }
  //       break;
  //     case 2:
  //       if (!Provider.of<HeardPage2State>(context, listen: false).maleCheck) {
  //         context.read<HeardPage2State>().changeFirstAccessMaleCounter();
  //         controllerSecond.text =
  //             (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
  //                 .toString();
  //       }
  //       break;
  //     case 3:
  //       if (!Provider.of<HeardPage2State>(context, listen: false).femaleCheck) {
  //         context.read<HeardPage2State>().changeFirstAccessFemaleCounter();
  //         controllerThird.text =
  //             (Provider.of<HeardPage2State>(context, listen: false)
  //                     .femaleCounter)
  //                 .toString();
  //       }
  //       break;
  //     default:
  //   }
  //   setState(() {});
  // }

  // void changeCheck(int id) {
  //   switch (id) {
  //     case 1:
  //       context.read<HeardPage2State>().changeTotalCheck();
  //       isCheckedFirst =
  //           (Provider.of<HeardPage2State>(context, listen: false).totalCheck);
  //       if (!Provider.of<HeardPage2State>(context, listen: false).maleCheck) {
  //         context.read<HeardPage2State>().changeMaleCheck();
  //         isCheckedSecond =
  //             (Provider.of<HeardPage2State>(context, listen: false).maleCheck);
  //       }
  //       if (!Provider.of<HeardPage2State>(context, listen: false).femaleCheck) {
  //         context.read<HeardPage2State>().changeFemaleCheck();
  //         isCheckedThird = (Provider.of<HeardPage2State>(context, listen: false)
  //             .femaleCheck);
  //       }
  //       break;
  //     case 2:
  //       context.read<HeardPage2State>().changeMaleCheck();
  //       isCheckedSecond =
  //           (Provider.of<HeardPage2State>(context, listen: false).maleCheck);
  //       break;
  //     case 3:
  //       context.read<HeardPage2State>().changeFemaleCheck();
  //       isCheckedThird =
  //           (Provider.of<HeardPage2State>(context, listen: false).femaleCheck);
  //       break;
  //     default:
  //   }
  // }

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
            return '';
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
            return '';
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
            return '';
          }
        }

      default:
        return ' ';
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

      default:
        return false;
    }
  }
}
