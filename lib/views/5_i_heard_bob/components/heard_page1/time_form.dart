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

  _showTimePicker() async {
    myTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: kPrimaryColor,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: kColor3,
                hourMinuteColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.selected)
                        ? kTextLightColor
                        : kTextColor),
              ),
              textTheme: const TextTheme(
                labelSmall: TextStyle(
                  color: kTextColor,
                ),
                bodySmall: TextStyle(
                  color: kTextColor,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => kTextColor),
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              )),
              colorScheme: const ColorScheme.light(
                surface: kTextColor,
                primary: kTextColor,
              ),
            ),
            child: Localizations.override(
              context: context,
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false, textScaleFactor: 1),
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: child!),
              ),
            ),
          );
        },
        context: context,
        initialTime: TimeOfDay.now());

    setState(() {
      DateTime date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, myTime!.hour, myTime!.minute);

      String time = DateFormat('hh:mm a').format(date);

      changeTime(time);

      timeController.text = time;
    });
  }
}
