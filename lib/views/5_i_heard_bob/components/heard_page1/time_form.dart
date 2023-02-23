import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page1_state.dart';

class TimeForm extends StatefulWidget {
  const TimeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeForm> createState() => TimeFormState();
}

class TimeFormState extends State<TimeForm> {
  TimeOfDay? myTime = TimeOfDay.now();
  String time = DateFormat('hh:mm a').format(DateTime.now());
  TextEditingController timeController = TextEditingController();

  var items = [
    'Eastern (UTC -5H)',
    'Central (UTC -6H)',
    'Mountain (UTC -7H)',
    'Pacific (UTC -8H)',
    'Alaska (UTC -9H)',
    'Hawaii-Aleutian (UTC -10H)'
  ];

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
            ),
            child: Row(
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    color: kTextLightColor,
                  ),
                ),
                const Spacer(),
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  splashColor: Colors.transparent,
                  onTap: () => _showTimePicker(),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon-edit.svg",
                            height: 14,
                            color: kColor1,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "change",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            color: kTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextFormField(
                  onTap: () => _showTimePicker(),
                  style: TextStyle(
                      color: kTextColor,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp),
                  cursorColor: kTextColor,
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withAlpha(200),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 20,
                      borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22),
                        width: .5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 4,
                      borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22),
                        width: .5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kTextColor.withOpacity(0.22), width: 0.3),
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 4),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: SvgPicture.asset(
                        "assets/icons/icon-clock.svg",
                      ),
                    ),
                    prefixIconConstraints:
                        BoxConstraints(maxHeight: 28.w, maxWidth: 28.w),
                    hintText: "",
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: _CustomDropDownMenu(items: items),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initialization() {
    String localTime =
        Provider.of<HeardPage1State>(context, listen: false).time;
    if (localTime != '') {
      timeController = TextEditingController(text: localTime);
    } else {
      timeController = TextEditingController(text: time);
      changeTime(time);
    }
  }

  void changeTime(String time) {
    context.read<HeardPage1State>().changeTime(time);
  }

  void changeValue(String value) {
    context.read<HeardPage1State>().changeTimeZone(value);
  }

  _showTimePicker() {
    // myTime = await showTimePicker(
    //     initialEntryMode: TimePickerEntryMode.inputOnly,
    //     builder: (BuildContext context, Widget? child) {
    //       return Theme(
    //         data: Theme.of(context).copyWith(
    //           textSelectionTheme: const TextSelectionThemeData(
    //             cursorColor: kPrimaryColor,
    //           ),
    //           timePickerTheme: TimePickerThemeData(
    //             backgroundColor: kColor3,
    //             hourMinuteColor:
    //                 MaterialStateColor.resolveWith((states) => Colors.white),
    //             hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
    //                 states.contains(MaterialState.selected)
    //                     ? kTextLightColor
    //                     : kTextColor),
    //           ),
    //           textTheme: const TextTheme(
    //             labelSmall: TextStyle(
    //               color: kTextColor,
    //             ),
    //             bodySmall: TextStyle(
    //               color: kTextColor,
    //             ),
    //           ),
    //           textButtonTheme: TextButtonThemeData(
    //               style: ButtonStyle(
    //             foregroundColor:
    //                 MaterialStateColor.resolveWith((states) => kTextColor),
    //             overlayColor: MaterialStateColor.resolveWith(
    //                 (states) => Colors.transparent),
    //           )),
    //           colorScheme: const ColorScheme.light(
    //             surface: kTextColor,
    //             primary: kTextColor,
    //           ),
    //         ),
    //         child: Localizations.override(
    //           context: context,
    //           child: MediaQuery(
    //             data: MediaQuery.of(context)
    //                 .copyWith(alwaysUse24HourFormat: false, textScaleFactor: 1),
    //             child: GestureDetector(
    //                 onTap: () => FocusScope.of(context).unfocus(),
    //                 child: Container(
    //                   height: 20,
    //                   width: 100,
    //                   color: Colors.red,
    //                   child: Text("Provaa"),
    //                 )), //TODO
    //           ),
    //         ),
    //       );
    //     },
    //     context: context,
    //     initialTime: TimeOfDay.now());

    int hour = 0;
    int minute = 0;
    String value = 'Santa Fe (GMT -7H)';
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setstate) => Stack(
              alignment: Alignment.center,
              children: [
                Card(
                  child: Container(
                    height: 400.h,
                    width: 370.w,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                        color: kColor3,
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Enter Time",
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                                fontSize: 24.sp),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            "Time zone",
                            style: TextStyle(
                                height: 1,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                color: kTextColor,
                                fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: _CustomDropDownMenu(items: items),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: const _TimePicker(),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  hour = tmpHour;
                                  minute = tmpMinute;
                                  value = tmpValue;
                                  if (!_isSelectedAM) hour += 12;
                                  if (hour == 24) hour = 12;
                                  if (hour == 12 && _isSelectedAM) hour = 0;
                                  myTime =
                                      TimeOfDay(hour: hour, minute: minute);
                                  setState(() {
                                    DateTime date = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        myTime!.hour,
                                        myTime!.minute);

                                    String time =
                                        DateFormat('hh:mm a').format(date);

                                    changeTime(time);

                                    timeController.text = time;

                                    print(time);
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _TimePicker extends StatefulWidget {
  const _TimePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<_TimePicker> createState() => __TimePickerState();
}

int tmpHour = 1;
int tmpMinute = 0;
bool _isSelectedAM = true;

class __TimePickerState extends State<_TimePicker> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
    tmpHour = 1;
    tmpMinute = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 260.w,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // // hours wheel
                  SizedBox(
                    width: 110.w,
                    height: 95.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 95.h,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (index) {
                              tmpHour = index + 1;
                            },
                            controller: _controller,
                            itemExtent: 100,
                            perspective: 0.001,
                            diameterRatio: 1,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder: (context, index) {
                                return MyHours(
                                  hours: index + 1,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    ':',
                    style: TextStyle(
                        color: kTextLightColor,
                        fontFamily: 'Manrope',
                        fontSize: 68.sp,
                        fontWeight: FontWeight.w600),
                  ),

                  // minutes wheel
                  SizedBox(
                    width: 120.w,
                    height: 95.h,
                    child: ListWheelScrollView.useDelegate(
                      onSelectedItemChanged: (index) {
                        tmpMinute = index;
                      },
                      itemExtent: 100,
                      perspective: 0.001,
                      diameterRatio: 1,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 60,
                        builder: (context, index) {
                          return MyMinutes(
                            mins: index,
                          );
                        },
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: 15.w,
                  // ),
                  // // am or pm
                  // SizedBox(
                  //   width: 70,
                  //   height: 100.h,
                  //   child: ListWheelScrollView.useDelegate(
                  //     itemExtent: 50,
                  //     perspective: 0.005,
                  //     diameterRatio: 1.2,
                  //     physics: const FixedExtentScrollPhysics(),
                  //     childDelegate: ListWheelChildBuilderDelegate(
                  //       childCount: 2,
                  //       builder: (context, index) {
                  //         if (index == 0) {
                  //           return const AmPm(
                  //             isItAm: true,
                  //           );
                  //         } else {
                  //           return const AmPm(
                  //             isItAm: false,
                  //           );
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Hour',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: kTextLightColor,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Minute',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: kTextLightColor,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
        // SizedBox(
        //   width: 5.w,
        // ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4.r),
            ),
          ),
          height: 90.h,
          width: 48.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _isSelectedAM = true;
                  setState(() {});
                },
                child: Container(
                  color: _isSelectedAM
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.transparent,
                  height: 43.88.h,
                  width: 48.w,
                  child: Center(
                    child: Text(
                      'AM',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Manrope'),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                height: 0,
                thickness: 1,
              ),
              InkWell(
                onTap: () {
                  _isSelectedAM = false;
                  setState(() {});
                },
                child: Container(
                  height: 43.88.h,
                  width: 48.w,
                  color: !_isSelectedAM
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.transparent,
                  child: Center(
                      child: Text(
                    'PM',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Manrope'),
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class AmPm extends StatelessWidget {
//   final bool isItAm;
//   const AmPm({super.key, required this.isItAm});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Container(
//         child: Center(
//           child: Text(
//             isItAm == true ? 'am' : 'pm',
//             style: const TextStyle(
//               fontSize: 40,
//               color: kTextColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyHours extends StatelessWidget {
  final int hours;

  const MyHours({
    required this.hours,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Text(
        hours.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 68.sp,
          color: kTextLightColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
        ),
      ),
    );
  }
}

class MyMinutes extends StatelessWidget {
  final int mins;

  const MyMinutes({
    required this.mins,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Text(
        mins < 10 ? '0$mins' : mins.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 68.w,
          color: kTextLightColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
        ),
      ),
    );
  }
}

String tmpValue = 'Santa Fe (GMT -7H)';

class _CustomDropDownMenu extends StatefulWidget {
  const _CustomDropDownMenu({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  State<_CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<_CustomDropDownMenu> {
  late String dropdownvalue;

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeValue(String value) {
    context.read<HeardPage1State>().changeTimeZone(value);
  }

  void _initialization() {
    dropdownvalue =
        Provider.of<HeardPage1State>(context, listen: false).timeZone;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent,
          border: Border.all(
            color: kTextColor.withOpacity(0.22),
            width: 0.5,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
              dropdownColor: kColor3,
              decoration: InputDecoration(
                fillColor: kColor3.withAlpha(200),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kTextColor.withOpacity(0.22),
                    width: 0.3,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kTextColor.withOpacity(0.22),
                    width: 0.3,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kTextColor.withOpacity(0.22),
                    width: 0.3,
                  ),
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              style: TextStyle(
                color: kTextColor,
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
              isExpanded: true,
              value: dropdownvalue,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: kTextColor,
                size: 28,
              ),
              items: widget.items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SvgPicture.asset("assets/icons/icon-bird.svg"),
                      // SizedBox(
                      //   width: 5.w,
                      // ),
                      Text(
                        item,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            color: kTextColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                changeValue(
                    newValue!); //Serve, una volta modificato fuori al picker questo viene visto anche dentro al picker

                setState(() {
                  tmpValue = newValue;
                  dropdownvalue = newValue;
                });
              }),
        ),
      ),
    );
  }
}
