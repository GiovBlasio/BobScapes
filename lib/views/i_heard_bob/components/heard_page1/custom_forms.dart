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
        Padding(
          padding: EdgeInsets.only(
              // left: getProportionateScreenWidth(15),
              bottom: getProportionateScreenWidth(4),
              top: getProportionateScreenHeight(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Date",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () async {
                  myTime = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            textSelectionTheme: const TextSelectionThemeData(
                              cursorColor: Colors.white,
                            ),
                            timePickerTheme: TimePickerThemeData(
                              backgroundColor: kColor3,
                              hourMinuteColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              hourMinuteTextColor:
                                  MaterialStateColor.resolveWith((states) =>
                                      states.contains(MaterialState.selected)
                                          ? Colors.pink
                                          : Colors.black),
                            ),
                            textTheme: const TextTheme(
                              labelSmall: TextStyle(
                                color: Colors.white,
                              ),
                              bodySmall: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            textButtonTheme: TextButtonThemeData(
                                style: ButtonStyle(
                              // backgroundColor: MaterialStateColor.resolveWith(
                              //     (states) => Colors.black),
                              foregroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            )),
                            colorScheme: const ColorScheme.light(
                              surface: kColor3,
                              primary: Colors.white, // header background color
                              // onPrimary: Colors.white, // header text color
                              // onSurface: Colors.white, // body text color
                            ),
                          ),
                          child: Localizations.override(
                            context: context,
                            // locale: const Locale('it', 'IT'),
                            child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: false),
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
                    DateTime date = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        myTime!.hour,
                        myTime!.minute);

                    String time = DateFormat('hh:mm a').format(date);

                    changeTime(time);

                    timeController.text = time;
                  });
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                splashColor: Colors.transparent,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/edit.svg",
                      height: getProportionateScreenHeight(30),
                      color: Colors.white,
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: TextFormField(
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12.5),
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(200),
              // TODO
              contentPadding: EdgeInsets.all(
                getProportionateScreenWidth(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 20,
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                  gapPadding: 20),
              hintText: "",
            ),
            textAlign: TextAlign.center,
            controller: timeController,
            readOnly: true,
            onSaved: (newValue) {},
            onFieldSubmitted: (value) => {setState(() {})},
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Padding(
          padding: EdgeInsets.only(
              // left: getProportionateScreenWidth(15),
              bottom: getProportionateScreenWidth(4),
              top: getProportionateScreenHeight(10)),
          child: Row(
            children: [
              Text(
                "Time",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () async {
                  myDate = await showDatePicker(
                    keyboardType: TextInputType.datetime,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: kColor3)),
                        textTheme: Theme.of(context).textTheme.apply(
                              bodyColor: Colors.black,
                            ),
                        textSelectionTheme: const TextSelectionThemeData(
                          cursorColor: Colors.black,
                          selectionColor: Colors.transparent,
                        ),
                        colorScheme: const ColorScheme.light(
                          primary: kColor3, // header background color
                          onPrimary: Colors.white, // header text color

                          // surface: Colors.re // body text color
                        ),
                        dialogBackgroundColor: Colors.white,
                        // dialogTheme: DialogTheme(
                        //   backgroundColor: Colors.white,
                        // ),
                        textButtonTheme: const TextButtonThemeData(
                            // backgroundColor:k,
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll(Colors.black),
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.transparent)) // button text color
                            ),
                      ),
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: child!),
                    ),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now().add(const Duration(days: 0)),
                  );
                  setState(() {
                    String time = DateFormat("MM/dd/''yy").format(myDate!);
                    changeDate(time);
                    dateController.text = time;
                  });
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                splashColor: Colors.transparent,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/edit.svg",
                      height: getProportionateScreenHeight(30),
                      color: Colors.white,
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
              fillColor: Colors.white.withAlpha(200),
              // TODO
              contentPadding: EdgeInsets.all(
                getProportionateScreenWidth(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 20,
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                  gapPadding: 20),
              hintText: "",
            ),
            textAlign: TextAlign.center,
            controller: dateController,
            readOnly: true,
            onFieldSubmitted: (value) => {setState(() {})},
          ),
        ),
        // Row(
        //   children: [
        //     Flexible(
        //       child: TextFormField(
        //         style: TextStyle(
        //             fontSize: getProportionateScreenWidth(13.5),
        //             color: Colors.white,
        //             fontWeight: FontWeight.w600),
        //         cursorColor: Colors.white,
        //         onSaved: (newValue) {},
        //         decoration: InputDecoration(
        //           filled: true,
        //           fillColor: Colors.white.withAlpha(200),
        //           // TODO
        //           contentPadding: EdgeInsets.all(
        //             getProportionateScreenWidth(12),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(8),
        //             gapPadding: 20,
        //             borderSide: BorderSide.none,
        //           ),
        //           border: OutlineInputBorder(
        //               borderSide: BorderSide.none,
        //               borderRadius: BorderRadius.circular(8),
        //               gapPadding: 20),
        //           hintText: "",
        //         ),
        //         textAlign: TextAlign.center,
        //         controller: dateController,
        //         readOnly: true,
        //         onFieldSubmitted: (value) => {setState(() {})},
        //       ),
        //     ),
        //     SizedBox(
        //       width: getProportionateScreenWidth(10),
        //     ),
        //     InkWell(
        //       onTap: () async {
        //         myDate = await showDatePicker(
        //           keyboardType: TextInputType.datetime,
        //           initialEntryMode: DatePickerEntryMode.calendarOnly,
        //           builder: (context, child) => Theme(
        //             data: Theme.of(context).copyWith(
        //               inputDecorationTheme: const InputDecorationTheme(
        //                   filled: true,
        //                   fillColor: Colors.white,
        //                   labelStyle: TextStyle(color: kColor3)),
        //               textTheme: Theme.of(context).textTheme.apply(
        //                     bodyColor: Colors.black,
        //                   ),
        //               textSelectionTheme: const TextSelectionThemeData(
        //                 cursorColor: Colors.black,
        //                 selectionColor: Colors.transparent,
        //               ),
        //               colorScheme: const ColorScheme.light(
        //                 primary: kColor3, // header background color
        //                 onPrimary: Colors.white, // header text color

        //                 // surface: Colors.re // body text color
        //               ),
        //               dialogBackgroundColor: Colors.white,
        //               // dialogTheme: DialogTheme(
        //               //   backgroundColor: Colors.white,
        //               // ),
        //               textButtonTheme: const TextButtonThemeData(
        //                   // backgroundColor:k,
        //                   style: ButtonStyle(
        //                       foregroundColor:
        //                           MaterialStatePropertyAll(Colors.black),
        //                       overlayColor: MaterialStatePropertyAll(
        //                           Colors.transparent)) // button text color
        //                   ),
        //             ),
        //             child: GestureDetector(
        //                 onTap: () => FocusScope.of(context).unfocus(),
        //                 child: child!),
        //           ),
        //           context: context,
        //           initialDate: DateTime.now(),
        //           firstDate: DateTime.now().subtract(const Duration(days: 30)),
        //           lastDate: DateTime.now().add(const Duration(days: 0)),
        //         );
        //         setState(() {
        //           String time = DateFormat("MM/dd/''yy").format(myDate!);
        //           changeDate(time);
        //           dateController.text = time;
        //         });
        //       },
        //       overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        //       splashColor: Colors.transparent,
        //       child: Column(
        //         children: [
        //           SvgPicture.asset(
        //             "assets/icons/edit.svg",
        //             height: getProportionateScreenHeight(30),
        //             color: Colors.white,
        //           ),
        //           Text(
        //             "Change",
        //             style: TextStyle(
        //               fontSize: getProportionateScreenWidth(12),
        //               fontWeight: FontWeight.w700,
        //               color: Colors.white,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //       width: getProportionateScreenWidth(10),
        //     ),
        //     Flexible(
        //       child: TextFormField(
        //         style: TextStyle(
        //           fontSize: getProportionateScreenWidth(12.5),
        //           color: Colors.white,
        //           fontWeight: FontWeight.w600,
        //         ),
        //         decoration: InputDecoration(
        //           filled: true,
        //           fillColor: Colors.white.withAlpha(200),
        //           // TODO
        //           contentPadding: EdgeInsets.all(
        //             getProportionateScreenWidth(12),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(8),
        //             gapPadding: 20,
        //             borderSide: BorderSide.none,
        //           ),
        //           border: OutlineInputBorder(
        //               borderSide: BorderSide.none,
        //               borderRadius: BorderRadius.circular(8),
        //               gapPadding: 20),
        //           hintText: "",
        //         ),
        //         textAlign: TextAlign.center,
        //         controller: timeController,
        //         readOnly: true,
        //         onSaved: (newValue) {},
        //         onFieldSubmitted: (value) => {setState(() {})},
        //       ),
        //     ),
        //     SizedBox(
        //       width: getProportionateScreenWidth(10),
        //     ),
        //     InkWell(
        //       onTap: () async {
        //         myTime = await showTimePicker(
        //             initialEntryMode: TimePickerEntryMode.inputOnly,
        //             builder: (BuildContext context, Widget? child) {
        //               return Theme(
        //                 data: Theme.of(context).copyWith(
        //                   textSelectionTheme: const TextSelectionThemeData(
        //                     cursorColor: Colors.white,
        //                   ),
        //                   timePickerTheme: TimePickerThemeData(
        //                     backgroundColor: kColor3,
        //                     hourMinuteColor: MaterialStateColor.resolveWith(
        //                         (states) => Colors.white),
        //                     hourMinuteTextColor: MaterialStateColor.resolveWith(
        //                         (states) =>
        //                             states.contains(MaterialState.selected)
        //                                 ? Colors.pink
        //                                 : Colors.black),
        //                   ),
        //                   textTheme: const TextTheme(
        //                     labelSmall: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                     bodySmall: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   textButtonTheme: TextButtonThemeData(
        //                       style: ButtonStyle(
        //                     // backgroundColor: MaterialStateColor.resolveWith(
        //                     //     (states) => Colors.black),
        //                     foregroundColor: MaterialStateColor.resolveWith(
        //                         (states) => Colors.white),
        //                     overlayColor: MaterialStateColor.resolveWith(
        //                         (states) => Colors.transparent),
        //                   )),
        //                   colorScheme: const ColorScheme.light(
        //                     surface: kColor3,
        //                     primary: Colors.white, // header background color
        //                     // onPrimary: Colors.white, // header text color
        //                     // onSurface: Colors.white, // body text color
        //                   ),
        //                 ),
        //                 child: Localizations.override(
        //                   context: context,
        //                   // locale: const Locale('it', 'IT'),
        //                   child: MediaQuery(
        //                     data: MediaQuery.of(context)
        //                         .copyWith(alwaysUse24HourFormat: false),
        //                     child: GestureDetector(
        //                         onTap: () => FocusScope.of(context).unfocus(),
        //                         child: child!),
        //                   ),
        //                 ),
        //               );
        //             },
        //             context: context,
        //             initialTime: TimeOfDay.now());

        //         setState(() {
        //           DateTime date = DateTime(
        //               DateTime.now().year,
        //               DateTime.now().month,
        //               DateTime.now().day,
        //               myTime!.hour,
        //               myTime!.minute);

        //           String time = DateFormat('hh:mm a').format(date);

        //           changeTime(time);

        //           timeController.text = time;
        //         });
        //       },
        //       overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        //       splashColor: Colors.transparent,
        //       child: Column(
        //         children: [
        //           SvgPicture.asset(
        //             "assets/icons/edit.svg",
        //             height: getProportionateScreenHeight(30),
        //             color: Colors.white,
        //           ),
        //           Text(
        //             "Change",
        //             style: TextStyle(
        //               fontSize: getProportionateScreenWidth(12),
        //               fontWeight: FontWeight.w700,
        //               color: Colors.white,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //     SizedBox(
        //       width: getProportionateScreenWidth(5),
        //     )
        //   ],
        // ),
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

// class DateAndTimeForm extends StatefulWidget {
//   const DateAndTimeForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DateAndTimeForm> createState() => _DateAndTimeFormState();
// }

// class _DateAndTimeFormState extends State<DateAndTimeForm> {
//   DateTime? myDate = DateTime.now();
//   TimeOfDay? myTime = TimeOfDay.now();

//   String time = DateFormat('dd-MM-yyyy - kk:mm').format(DateTime.now());

//   TextEditingController dateController = TextEditingController();
//   TextEditingController timeController = TextEditingController();

//   @override
//   void initState() {
//     _initialization();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   // left: getProportionateScreenWidth(15),
//                   bottom: getProportionateScreenWidth(4),
//                   top: getProportionateScreenHeight(10)),
//               child: Text(
//                 "Date",
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(13),
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Padding(
//               padding: EdgeInsets.only(
//                   // left: getProportionateScreenWidth(15),
//                   bottom: getProportionateScreenWidth(4),
//                   top: getProportionateScreenHeight(10)),
//               child: Text(
//                 "Time",
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(13),
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const Spacer()
//           ],
//         ),
//         Row(
//           children: [
//             Flexible(
//               child: TextFormField(
//                 style: TextStyle(
//                     fontSize: getProportionateScreenWidth(13.5),
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600),
//                 cursorColor: Colors.white,
//                 onSaved: (newValue) {},
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white.withAlpha(200),
//                   // TODO
//                   contentPadding: EdgeInsets.all(
//                     getProportionateScreenWidth(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     gapPadding: 20,
//                     borderSide: BorderSide.none,
//                   ),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(8),
//                       gapPadding: 20),
//                   hintText: "",
//                 ),
//                 textAlign: TextAlign.center,
//                 controller: dateController,
//                 readOnly: true,
//                 onFieldSubmitted: (value) => {setState(() {})},
//                 // onTap: () async {
//                 //   myDate = await showDatePicker(
//                 //     keyboardType: TextInputType.datetime,
//                 //     initialEntryMode: DatePickerEntryMode.calendarOnly,
//                 //     builder: (context, child) => Theme(
//                 //       data: Theme.of(context).copyWith(
//                 //         // textTheme: Theme.of(context).textTheme.apply(
//                 //         //       bodyColor: Colors.white,
//                 //         //     ),
//                 //         textTheme: Theme.of(context).primaryTextTheme,
//                 //         textSelectionTheme: const TextSelectionThemeData(
//                 //           cursorColor: Colors.white,
//                 //           selectionColor: Colors.transparent,
//                 //         ),
//                 //         colorScheme: const ColorScheme.light(
//                 //           primary: kColor3, // header background color

//                 //           onPrimary: Colors.white, // header text color
//                 //           onSurface: Colors.white, // body text color
//                 //         ),
//                 //         dialogBackgroundColor: kColor3,
//                 //         textButtonTheme: TextButtonThemeData(
//                 //           style: TextButton.styleFrom(
//                 //             // backgroundColor:k,
//                 //             foregroundColor: Colors.white, // button text color
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       child: child!,
//                 //     ),
//                 //     context: context,
//                 //     initialDate: DateTime.now(),
//                 //     firstDate:
//                 //         DateTime.now().subtract(const Duration(days: 30)),
//                 //     lastDate: DateTime.now().add(const Duration(days: 0)),
//                 //   );

//                 //   setState(() {
//                 //     String time = DateFormat("dd/MM/''yy").format(myDate!);

//                 //     changeDate(time);
//                 //     dateController.text = time;
//                 //   });
//                 // },
//               ),
//             ),
//             SizedBox(
//               width: getProportionateScreenWidth(10),
//             ),
//             InkWell(
//               onTap: () async {
//                 myDate = await showDatePicker(
//                   keyboardType: TextInputType.datetime,
//                   initialEntryMode: DatePickerEntryMode.calendarOnly,
//                   builder: (context, child) => Theme(
//                     data: Theme.of(context).copyWith(
//                       inputDecorationTheme: const InputDecorationTheme(
//                           filled: true,
//                           fillColor: Colors.white,
//                           labelStyle: TextStyle(color: kColor3)),
//                       textTheme: Theme.of(context).textTheme.apply(
//                             bodyColor: Colors.black,
//                           ),
//                       textSelectionTheme: const TextSelectionThemeData(
//                         cursorColor: Colors.black,
//                         selectionColor: Colors.transparent,
//                       ),
//                       colorScheme: const ColorScheme.light(
//                         primary: kColor3, // header background color
//                         onPrimary: Colors.white, // header text color

//                         // surface: Colors.re // body text color
//                       ),
//                       dialogBackgroundColor: Colors.white,
//                       // dialogTheme: DialogTheme(
//                       //   backgroundColor: Colors.white,
//                       // ),
//                       textButtonTheme: const TextButtonThemeData(
//                           // backgroundColor:k,
//                           style: ButtonStyle(
//                               foregroundColor:
//                                   MaterialStatePropertyAll(Colors.black),
//                               overlayColor: MaterialStatePropertyAll(
//                                   Colors.transparent)) // button text color
//                           ),
//                     ),
//                     child: GestureDetector(
//                         onTap: () => FocusScope.of(context).unfocus(),
//                         child: child!),
//                   ),
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now().subtract(const Duration(days: 30)),
//                   lastDate: DateTime.now().add(const Duration(days: 0)),
//                 );
//                 setState(() {
//                   String time = DateFormat("MM/dd/''yy").format(myDate!);
//                   changeDate(time);
//                   dateController.text = time;
//                 });
//               },
//               overlayColor: const MaterialStatePropertyAll(Colors.transparent),
//               splashColor: Colors.transparent,
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/icons/edit.svg",
//                     height: getProportionateScreenHeight(30),
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Change",
//                     style: TextStyle(
//                       fontSize: getProportionateScreenWidth(12),
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: getProportionateScreenWidth(10),
//             ),
//             Flexible(
//               child: TextFormField(
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(12.5),
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white.withAlpha(200),
//                   // TODO
//                   contentPadding: EdgeInsets.all(
//                     getProportionateScreenWidth(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     gapPadding: 20,
//                     borderSide: BorderSide.none,
//                   ),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(8),
//                       gapPadding: 20),
//                   hintText: "",
//                 ),
//                 textAlign: TextAlign.center,
//                 controller: timeController,
//                 readOnly: true,
//                 onSaved: (newValue) {},
//                 onFieldSubmitted: (value) => {setState(() {})},
//                 // onTap: () async {
//                 //   myTime = await showTimePicker(
//                 //       initialEntryMode: TimePickerEntryMode.inputOnly,
//                 //       builder: (BuildContext context, Widget? child) {
//                 //         return Theme(
//                 //           data: Theme.of(context).copyWith(
//                 //             textSelectionTheme: const TextSelectionThemeData(
//                 //               cursorColor: Colors.white,
//                 //             ),
//                 //             timePickerTheme: TimePickerThemeData(
//                 //               backgroundColor: kColor3,
//                 //               hourMinuteColor: MaterialStateColor.resolveWith(
//                 //                   (states) => Colors.white),
//                 //               hourMinuteTextColor:
//                 //                   MaterialStateColor.resolveWith((states) =>
//                 //                       states.contains(MaterialState.selected)
//                 //                           ? Colors.pink
//                 //                           : Colors.black),
//                 //             ),
//                 //             textTheme: const TextTheme(
//                 //               labelSmall: TextStyle(
//                 //                 color: Colors.white,
//                 //               ),
//                 //               bodySmall: TextStyle(
//                 //                 color: Colors.white,
//                 //               ),
//                 //             ),
//                 //             textButtonTheme: TextButtonThemeData(
//                 //                 style: ButtonStyle(
//                 //               // backgroundColor: MaterialStateColor.resolveWith(
//                 //               //     (states) => Colors.black),
//                 //               foregroundColor: MaterialStateColor.resolveWith(
//                 //                   (states) => Colors.white),
//                 //               overlayColor: MaterialStateColor.resolveWith(
//                 //                   (states) => Colors.transparent),
//                 //             )),
//                 //             colorScheme: const ColorScheme.light(
//                 //               surface: kColor3,
//                 //               primary: Colors.white, // header background color
//                 //               // onPrimary: Colors.white, // header text color
//                 //               // onSurface: Colors.white, // body text color
//                 //             ),
//                 //           ),
//                 //           child: Localizations.override(
//                 //             context: context,
//                 //             // locale: const Locale('it', 'IT'),
//                 //             child: MediaQuery(
//                 //               data: MediaQuery.of(context)
//                 //                   .copyWith(alwaysUse24HourFormat: false),
//                 //               child: child!,
//                 //             ),
//                 //           ),
//                 //         );
//                 //       },
//                 //       context: context,
//                 //       initialTime: TimeOfDay.now());

//                 //   setState(() {
//                 //     DateTime date = DateTime(
//                 //         DateTime.now().year,
//                 //         DateTime.now().month,
//                 //         DateTime.now().day,
//                 //         myTime!.hour,
//                 //         myTime!.minute);

//                 //     String time = DateFormat('hh:mm a').format(date);

//                 //     changeTime(time);

//                 //     timeController.text = time;
//                 //   });
//                 // },
//               ),
//             ),
//             SizedBox(
//               width: getProportionateScreenWidth(10),
//             ),
//             InkWell(
//               onTap: () async {
//                 myTime = await showTimePicker(
//                     initialEntryMode: TimePickerEntryMode.inputOnly,
//                     builder: (BuildContext context, Widget? child) {
//                       return Theme(
//                         data: Theme.of(context).copyWith(
//                           textSelectionTheme: const TextSelectionThemeData(
//                             cursorColor: Colors.white,
//                           ),
//                           timePickerTheme: TimePickerThemeData(
//                             backgroundColor: kColor3,
//                             hourMinuteColor: MaterialStateColor.resolveWith(
//                                 (states) => Colors.white),
//                             hourMinuteTextColor: MaterialStateColor.resolveWith(
//                                 (states) =>
//                                     states.contains(MaterialState.selected)
//                                         ? Colors.pink
//                                         : Colors.black),
//                           ),
//                           textTheme: const TextTheme(
//                             labelSmall: TextStyle(
//                               color: Colors.white,
//                             ),
//                             bodySmall: TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                           textButtonTheme: TextButtonThemeData(
//                               style: ButtonStyle(
//                             // backgroundColor: MaterialStateColor.resolveWith(
//                             //     (states) => Colors.black),
//                             foregroundColor: MaterialStateColor.resolveWith(
//                                 (states) => Colors.white),
//                             overlayColor: MaterialStateColor.resolveWith(
//                                 (states) => Colors.transparent),
//                           )),
//                           colorScheme: const ColorScheme.light(
//                             surface: kColor3,
//                             primary: Colors.white, // header background color
//                             // onPrimary: Colors.white, // header text color
//                             // onSurface: Colors.white, // body text color
//                           ),
//                         ),
//                         child: Localizations.override(
//                           context: context,
//                           // locale: const Locale('it', 'IT'),
//                           child: MediaQuery(
//                             data: MediaQuery.of(context)
//                                 .copyWith(alwaysUse24HourFormat: false),
//                             child: GestureDetector(
//                                 onTap: () => FocusScope.of(context).unfocus(),
//                                 child: child!),
//                           ),
//                         ),
//                       );
//                     },
//                     context: context,
//                     initialTime: TimeOfDay.now());

//                 setState(() {
//                   DateTime date = DateTime(
//                       DateTime.now().year,
//                       DateTime.now().month,
//                       DateTime.now().day,
//                       myTime!.hour,
//                       myTime!.minute);

//                   String time = DateFormat('hh:mm a').format(date);

//                   changeTime(time);

//                   timeController.text = time;
//                 });
//               },
//               overlayColor: const MaterialStatePropertyAll(Colors.transparent),
//               splashColor: Colors.transparent,
//               child: Column(
//                 children: [
//                   SvgPicture.asset(
//                     "assets/icons/edit.svg",
//                     height: getProportionateScreenHeight(30),
//                     color: Colors.white,
//                   ),
//                   Text(
//                     "Change",
//                     style: TextStyle(
//                       fontSize: getProportionateScreenWidth(12),
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: getProportionateScreenWidth(5),
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   void changeDate(String time) {
//     context.read<HeardPage1State>().changeDate(time);
//   }

//   void _initialization() {
//     String date = Provider.of<HeardPage1State>(context, listen: false).date;
//     if (date != '') dateController = TextEditingController(text: date);

//     String time = Provider.of<HeardPage1State>(context, listen: false).time;
//     if (time != '') timeController = TextEditingController(text: time);
//   }

//   void changeTime(String time) {
//     context.read<HeardPage1State>().changeTime(time);
//   }
// }

// class LocationForm extends StatefulWidget {
//   const LocationForm({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<LocationForm> createState() => _LocationFormState();
// }

// class _LocationFormState extends State<LocationForm> {
//   TextEditingController controller = TextEditingController();

//   @override
//   void initState() {
//     _initialization();
//     super.initState();
//   }

//   void changeLocation(String location) {
//     context.read<HeardPage1State>().changeLocation(location);
//   }

//   void _initialization() {
//     String location =
//         Provider.of<HeardPage1State>(context, listen: false).location;

//     if (location != '') controller = TextEditingController(text: location);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//               //left: getProportionateScreenWidth(15),
//               bottom: getProportionateScreenWidth(4),
//               top: getProportionateScreenHeight(10)),
//           child: Text(
//             "Latitude/Longitude",
//             style: TextStyle(
//                 fontSize: getProportionateScreenWidth(13),
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white),
//           ),
//         ),
//         Row(children: [
//           Expanded(
//             child: Form(
//                 child: Row(
//               children: [
//                 Flexible(
//                   child: TextFormField(
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: getProportionateScreenWidth(14)),
//                     cursorColor: Colors.black,
//                     controller: controller,
//                     readOnly: true,
//                     onSaved: (newValue) {
//                       //  location = newValue ?? "";
//                     },
//                     onChanged: (value) {},
//                     validator: (value) {
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white.withAlpha(200),
//                       // TODO
//                       contentPadding: EdgeInsets.all(
//                         getProportionateScreenWidth(12),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           gapPadding: 20,
//                           borderSide: BorderSide
//                               .none), //const BorderSide(color: Colors.grey)),
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(8),
//                           gapPadding: 20),
//                       suffixIcon: Padding(
//                         padding: EdgeInsets.only(
//                             right: getProportionateScreenWidth(10)),
//                         child: SvgPicture.asset(
//                           "assets/icons/gpsArrow.svg",
//                           color: kColor1,
//                         ),
//                       ),
//                       suffixIconConstraints: BoxConstraints(
//                           maxHeight: getProportionateScreenHeight(33),
//                           maxWidth: getProportionateScreenWidth(33)),
//                       //suffixIconColor: Colors.white,
//                       hintText: "",
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: getProportionateScreenWidth(15),
//                 ),
//                 InkWell(
//                   overlayColor:
//                       const MaterialStatePropertyAll(Colors.transparent),
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     setState(() {
//                       String location = 'prova';
//                       changeLocation(location);
//                       controller.text = location;
//                     });
//                   },
//                   child: Column(
//                     children: [
//                       SvgPicture.asset(
//                         "assets/icons/edit.svg",
//                         height: getProportionateScreenHeight(30),
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Change",
//                         style: TextStyle(
//                             fontSize: getProportionateScreenWidth(12),
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: getProportionateScreenWidth(5),
//                 )
//               ],
//             )),
//           ),
//         ]),
//       ],
//     );
//   }
// }

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
              //left: getProportionateScreenWidth(15),
              bottom: getProportionateScreenWidth(4),
              top: getProportionateScreenHeight(10)),
          child: Row(
            children: [
              Text(
                "Latitude/Longitude",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor),
              ),
              Spacer(),
              InkWell(
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    String location = 'prova';
                    changeLocation(location);
                    controller.text = location;
                  });
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/edit.svg",
                      height: getProportionateScreenHeight(18),
                      color: kColor1,
                    ),
                  ],
                ),
              ),
              InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      String location = 'prova';
                      changeLocation(location);
                      controller.text = location;
                    });
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(10),
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor),
                  )),
            ],
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
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(14)),
                    cursorColor: Colors.black,
                    controller: controller,
                    readOnly: true,
                    onSaved: (newValue) {
                      //  location = newValue ?? "";
                    },
                    onChanged: (value) {},
                    validator: (value) {
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(200),
                      // TODO
                      contentPadding: EdgeInsets.all(
                        getProportionateScreenWidth(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          gapPadding: 20,
                          borderSide: BorderSide
                              .none), //const BorderSide(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(0),
                          gapPadding: 20),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(5)),
                        child: SvgPicture.asset(
                          "assets/icons/gpsArrow.svg",
                          color: kPrimaryColor,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                          maxHeight: getProportionateScreenHeight(23),
                          maxWidth: getProportionateScreenWidth(23)),
                      //suffixIconColor: Colors.white,
                      hintText: "",
                    ),
                  ),
                ),
                // SizedBox(
                //   width: getProportionateScreenWidth(15),
                // ),
              ],
            )),
          ),
        ]),
      ],
    );
  }
}
