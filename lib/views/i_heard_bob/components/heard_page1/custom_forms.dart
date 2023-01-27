import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateAndTimeForm extends StatefulWidget {
  const DateAndTimeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<DateAndTimeForm> createState() => _DateAndTimeFormState();
}

class _DateAndTimeFormState extends State<DateAndTimeForm> {
  DateTime? myDate = DateTime.now();
  TimeOfDay? myTime = TimeOfDay.now();

  String time = DateFormat('dd-MM-yyyy - kk:mm').format(DateTime.now());

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(15),
                  bottom: getProportionateScreenWidth(4),
                  top: getProportionateScreenHeight(10)),
              child: Text(
                "Date",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  left: getProportionateScreenWidth(15),
                  bottom: getProportionateScreenWidth(4),
                  top: getProportionateScreenHeight(10)),
              child: Text(
                "Time",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer()
          ],
        ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13.5),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                cursorColor: Colors.white,
                onSaved: (newValue) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xddc2c2c2),
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                    top: 0,
                    bottom: 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 20,
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                      gapPadding: 20),
                  hintText: "",
                ),
                textAlign: TextAlign.center,
                controller: dateController,
                readOnly: true,
                onFieldSubmitted: (value) => {setState(() {})},
                onTap: () async {
                  myDate = await showDatePicker(
                    // locale: const Locale("it", "IT"),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: kPrimaryColor, // header background color
                          onPrimary: Colors.white, // header text color
                          //onSurface: Colors.green, // body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: kPrimaryColor, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    ),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  setState(() {
                    String time = DateFormat('dd/MM/yy')
                        .format(myDate!)
                        .replaceRange(6, 6, '\'');
                    changeDate(time);
                    dateController.text = time;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Column(
              children: [
                SvgPicture.asset("assets/icons/edit.svg"),
                Text(
                  "Change",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12.5),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xddc2c2c2),
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                    top: 0,
                    bottom: 0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 20,
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                      gapPadding: 20),
                  hintText: "",
                ),
                textAlign: TextAlign.center,
                controller: timeController,
                readOnly: true,
                onSaved: (newValue) {},
                onFieldSubmitted: (value) => {setState(() {})},
                onTap: () async {
                  myTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: kPrimaryColor, // header background color
                              onPrimary: Colors.black, // header text color
                              //onSurface: Colors.green, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    kPrimaryColor, // button text color
                              ),
                            ),
                          ),
                          child: Localizations.override(
                            context: context,
                            // locale: const Locale('it', 'IT'),
                            child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            ),
                          ),
                        );
                      },
                      context: context,
                      initialTime: TimeOfDay.now());

                  setState(() {
                    DateTime date = DateTime.utc(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        myTime!.hour,
                        myTime!.minute);

                    String time = DateFormat('kk:mm')
                        .format(date)
                        .replaceRange(5, null, ' PM');

                    changeTime(time);

                    timeController.text = time;
                  });
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Column(
              children: [
                SvgPicture.asset("assets/icons/edit.svg"),
                Text(
                  "Change",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              width: getProportionateScreenWidth(5),
            )
          ],
        ),
      ],
    );
  }

  void changeDate(String time) {
    context.read<HeardPage1State>().changeDate(time);
  }

  void _initialization() {
    String date = Provider.of<HeardPage1State>(context, listen: false).date;
    if (date != '') dateController = TextEditingController(text: date);

    String time = Provider.of<HeardPage1State>(context, listen: false).time;
    if (time != '') timeController = TextEditingController(text: time);
  }

  void changeTime(String time) {
    context.read<HeardPage1State>().changeTime(time);
  }
}

class LocationForm extends StatefulWidget {
  const LocationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeLocation(String location) {
    context.read<HeardPage1State>().changeLocation(location);
  }

  void _initialization() {
    String location =
        Provider.of<HeardPage1State>(context, listen: false).location;

    if (location != '') controller = TextEditingController(text: location);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(15),
              bottom: getProportionateScreenWidth(4),
              top: getProportionateScreenHeight(10)),
          child: Text(
            "Latitude/Longitude",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.w700),
          ),
        ),
        Row(children: [
          Expanded(
            child: Form(
                child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(14)),
                    cursorColor: Colors.white,
                    controller: controller,
                    readOnly: true,
                    onSaved: (newValue) {
                      //  location = newValue ?? "";
                    },
                    onChanged: (value) {},
                    validator: (value) {
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        String location = 'prova';
                        changeLocation(location);
                        controller.text = location;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xddc2c2c2),
                      contentPadding: EdgeInsets.only(
                          left: getProportionateScreenWidth(20),
                          top: 0,
                          bottom: 0,
                          right: getProportionateScreenWidth(20)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          gapPadding: 20,
                          borderSide: BorderSide
                              .none), //const BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                          gapPadding: 20),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(
                            right: getProportionateScreenWidth(10)),
                        child: SvgPicture.asset(
                          "assets/icons/gpsArrow.svg",
                          color: Colors.white,
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(
                          maxHeight: getProportionateScreenHeight(25),
                          maxWidth: getProportionateScreenWidth(25)),
                      //suffixIconColor: Colors.white,
                      hintText: "",
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
                Column(
                  children: [
                    SvgPicture.asset("assets/icons/edit.svg"),
                    Text(
                      "Change",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(
                  width: getProportionateScreenWidth(5),
                )
              ],
            )),
          ),
        ]),
      ],
    );
  }
}
