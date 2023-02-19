import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page1_state.dart';

class DateForm extends StatefulWidget {
  const DateForm({
    super.key,
  });

  @override
  State<DateForm> createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {
  TextEditingController dateController = TextEditingController();
  DateTime? myDate = DateTime.now();

  String date = DateFormat("MM/dd/yy").format(DateTime.now());
  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeDate(String time) {
    context.read<HeardPage1State>().changeDate(time);
  }

  void _initialization() {
    String localDate =
        Provider.of<HeardPage1State>(context, listen: false).date;
    if (localDate != '') {
      dateController = TextEditingController(text: localDate);
    } else {
      dateController = TextEditingController(text: date);
      changeDate(date);
    }
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Date",
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
                  onTap: () => _showDatePicker(),
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
              style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
              controller: dateController,
              readOnly: true,
              cursorColor: kTextColor,
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
                    "assets/icons/icon-calendar.svg",
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 28.w,
                  maxWidth: 28.w,
                ),
                hintText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDatePicker() async {
    myDate = await showDatePicker(
      keyboardType: TextInputType.datetime,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kTextColor,
              labelStyle: TextStyle(color: kTextColor)),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kTextColor,
              ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: kTextColor,
            selectionColor: Colors.transparent,
          ),
          colorScheme: const ColorScheme.light(
            onSecondary: kTextColor,
            secondary: kTextColor,
            surface: kTextColor,
            onSurface: kTextColor,
            primary: kColor1,
            onPrimary: kTextColor,
          ),
          dialogBackgroundColor: Colors.white,
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(kTextColor),
                  overlayColor: MaterialStatePropertyAll(Colors.transparent))),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(), child: child!),
        ),
      ),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 0)),
    );
    setState(() {
      String time = DateFormat("MM/dd/yy").format(myDate!);
      changeDate(time);
      dateController.text = time;
    });
  }
}
