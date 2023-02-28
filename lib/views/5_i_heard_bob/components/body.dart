import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/heard_page/heard_page1_state.dart';
import '../../../provider/heard_page/heard_page2_state.dart';
import '../../../provider/heard_page/heard_page3_state.dart';
import '../../../services/remote_services.dart';
import '../../4_hear_bob/heard_bob.dart';
import '../../6_i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import '../../7_bob_sightings_map/bob_sightings.dart';
import '../../common_widget/bottom_buttons.dart';
import '../../common_widget/custom_title.dart';
import 'heard_page1/date_form.dart';
import 'heard_page1/time_form.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/location_form.dart';
import 'heard_page1/personal_info.dart';
import 'heard_page2/counters.dart';
import 'heard_page2/numerical_question.dart';
import 'heard_page2/custom_dropdown_menu.dart' as heard2;
import 'heard_page3/comment_form.dart';
import 'heard_page3/radio_button.dart' as heard3;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController pageController = PageController(keepPage: true);

  int currentIndex = 0;

  bool isLoaded = false;
  final List<String> itemsPage1 = [
    'Landowner',
    'Land manager',
    'Professional (Biologist, Researcher…)',
    'Other'
  ];

  final Set<String> radioOptionsPage1 = {
    'Yes',
    'No',
    'Within a\n half mile',
    'Unsure'
  };

  final Set<String> radioOptions2Page1 = {'Yes', 'No', '1', '2'};

  TextEditingController emailController = TextEditingController();

  TextEditingController controller = TextEditingController();

  late bool isEnabled = true;

  final _keyEmail = GlobalKey<FormState>();

  final _keyEmailFake = GlobalKey<FormState>();

  final _keyName = GlobalKey<FormState>();

  final _keyNameFake = GlobalKey<FormState>();

  // String hintEmail = "Your Email";

  // String hintName = "Your Name";

  String hintName = "Mikel Estel";

  String hintEmail = "hello@aol.com";

  late Map<String, dynamic> params;
  // = {
  // "name": name,
  // "email": email,
  // "title": title,
  // "latitude": latitude,
  // "longitude": longitude,
  // "datetime": datetime,
  // "physicallySee": physicallySee,
  // "releasedLocation": releasedLocation,
  // "whatSee": whatSee,
  // "mayBirds": manyBirds,
  // "manyMale": manyMale,
  // "manyFemale": manyFemale,
  // "manyYoung": manyYoung,
  // "manyBroods": manyBroods,
  // "moreInformation": moreInfo,
  // "learnMore": learnMore,
  // "comment": comment,
  // "state": locality
  //};

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeName(String name) {
    context.read<HeardPage1State>().changeName(name);
  }

  void changeEmail(String email) {
    context.read<HeardPage3State>().changeEmail(email);
  }

  void _initialization() {
    //  isEnabled = Provider.of<HeardPage3State>(context, listen: false).isEnable;

    String name = Provider.of<HeardPage1State>(context, listen: false).name;

    String email = Provider.of<HeardPage3State>(context, listen: false).email;

    if (email != '') {
      emailController = TextEditingController(text: email);
    }
    if (name != '') controller = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: SvgPicture.asset(
              "assets/images/sfondo3.svg",
              fit: BoxFit.cover,
              // width: double.infinity,
            ),
          ),
        ),
        Positioned(
          bottom: 65.h,
          top: 55.h,
          left: 0,
          right: 0,
          child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              controller: pageController,
              children: [
                _buildPage1(),
                if (Provider.of<HeardPage1State>(context).physicallySee ==
                    'Yes')
                  _buildPage2(),
                _buildPage3(context),
              ]),
        ),
        Positioned(
          top: 0,
          width: ScreenUtil().screenWidth,
          child: const CustomTitle(
            title: "I Heard Bob!",
            color: kColor2,
            icon: "assets/icons/gps.svg",
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              BottomButton(
                color: kColor3,
                title: "Bob Sightings Map",
                iconPath: "assets/icons/eye.svg",
                onPressed: () =>
                    Navigator.pushNamed(context, BobSightingsScreen.routeName),
              ),
              BottomButton(
                color: kColor1,
                title: "Hear Bob",
                iconPath: "assets/icons/music.svg",
                onPressed: () =>
                    Navigator.pushNamed(context, HearBobScreen.routeName),
              ),
            ],
          ),
        ),
        if (isLoaded)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kColor2),
              backgroundColor: kColor1,
            ),
          )
      ],
    );
  }

  Padding _buildEmailForm(Key key) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your email (required)',
              style: TextStyle(
                color: kTextLightColor,
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
            ),
            Flexible(
              child: TextFormField(
                style: const TextStyle(
                    color: kTextColor,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500),
                enableInteractiveSelection: false,
                cursorColor: kTextColor,
                enabled: true,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onTapOutside: (event) {
                  if (Provider.of<HeardPage3State>(context, listen: false)
                          .email ==
                      '') {
                    setState(() {
                      //  hintEmail = 'Your Email';
                      hintEmail = "hello@aol.com";
                    });
                  }
                },
                onTap: () {
                  setState(() {
                    hintEmail = '';
                  });
                },
                onChanged: (value) {
                  changeEmail(value);
                  if (key == _keyEmail) {
                    _keyEmail.currentState!.validate();
                    _keyEmailFake.currentState!.validate();
                  }
                  if (value.isEmpty || value == '') {
                    setState(() {
                      hintEmail = "hello@aol.com";
                    });
                  }
                },
                validator: (value) {
                  if (!_validateEmail(value!)) {
                    return 'Enter correct email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: kTextLightColor,
                      fontSize: 14.sp,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700),
                  hintStyle: TextStyle(
                    color: kTextColor.withOpacity(0.4),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // contentPadding: EdgeInsets.symmetric(),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    ),
                  ),
                  prefixIcon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SvgPicture.asset(
                      "assets/icons/icon-mail.svg",
                      height: 20.h,
                    ),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 28.w, maxWidth: 28.w),
                  hintText: hintEmail,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildNameForm(Key key) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your name (required)',
              style: TextStyle(
                color: kTextLightColor,
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
            ),
            Flexible(
              child: TextFormField(
                onTapOutside: (event) {
                  if (Provider.of<HeardPage1State>(context, listen: false)
                          .name ==
                      '') {
                    setState(() {
                      hintName = "Mikel Estel";
                    });
                  }
                },
                enableInteractiveSelection: false,
                controller: controller,
                keyboardType: TextInputType.name,
                onTap: () {
                  setState(() {
                    hintName = '';
                  });
                },
                onChanged: (value) {
                  changeName(value);
                  if (key == _keyName) {
                    _keyName.currentState!.validate();
                    _keyNameFake.currentState!.validate();
                  }
                  if (value.isEmpty || value == '') {
                    setState(() {
                      hintName = "Mikel Estel";
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return "Enter correct name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: kTextColor.withOpacity(0.4),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.w),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    ),
                  ),
                  hintText: hintName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    if (_keyEmail.currentState != null) {
      _keyEmail.currentState!.validate();
      _keyName.currentState!.validate();
      _keyEmailFake.currentState!.validate();
      _keyNameFake.currentState!.validate();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          top: 23.h,
                        ),
                        child: Text(
                          "Register your sighting",
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                              color: kTextColor,
                              fontSize: 21.sp),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          _buildNameForm(_keyNameFake),
                          SizedBox(
                            height: 28.h,
                          ),
                          _buildEmailForm(_keyEmailFake),
                          SizedBox(
                            height: 28.h,
                          ),
                          CustomDropDownMenu(items: itemsPage1),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      const LocationForm(),
                      SizedBox(
                        height: 25.h,
                      ),
                      const DateForm(),
                      SizedBox(
                        height: 25.h,
                      ),
                      const TimeForm(),
                      SizedBox(
                        height: 30.h,
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15.w,
                          left: 15.w,
                          top: 24.h,
                          bottom: 24.h,
                        ),
                        child: CustomRadioButton(
                            items: radioOptionsPage1,
                            title:
                                "Are Bobwhite released at the sightings location?",
                            id: 1),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15.w,
                          left: 15.w,
                          top: 24.h,
                          bottom: 24.h,
                        ),
                        child: CustomRadioButton(
                            items: radioOptions2Page1,
                            title: "Did you physically see any birds?",
                            id: 2),
                      ),
                      Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 45.h, bottom: 35.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.grey),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                onPressed: () {
                                  if (!isLoaded) {
                                    setState(() {
                                      pageController.animateToPage(
                                          currentIndex + 1,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.linear);
                                    });
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: kTextColor,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/icon-next-form.svg",
                                      height: 14,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Positioned(
                    top: 8.h,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      "assets/icons/mini-quail.svg",
                      height: 110.h,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  Positioned(
                    top: 80.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: kColor3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                            height: 0,
                            color: kColor1,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buildNameForm(_keyName),
                          SizedBox(
                            height: 28.h,
                          ),
                          _buildEmailForm(_keyEmail),
                          SizedBox(
                            height: 28.h,
                          ),
                          CustomDropDownMenu(items: itemsPage1),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            height: 0,
                            color: kColor1,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage2() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          top: 23.h,
                        ),
                        child: Text(
                          "Register your sighting",
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                              color: kTextColor,
                              fontSize: 21.sp),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     const heard2.CustomDropDownMenu(
                      //         items: ['Family (Covey)', 'Individual bird']),
                      //     SizedBox(
                      //       height: 20.h,
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   color: Colors.transparent,
                      //   height: 100.h,
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      const Counters(),
                      SizedBox(
                        height: 30.h,
                      ),
                      const Divider(
                        thickness: 2,
                        height: 0,
                        color: kColor1,
                      ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),

                      Container(
                        //padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                        color: kColor3.withAlpha(200),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              child: const NumericalQuestion(
                                  title: "How many broods?", id: 5),
                            ),
                            SizedBox(
                              height: 17.5.h,
                            ),
                            SizedBox(
                              height: 17.5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                              ),
                              child: const NumericalQuestion(
                                title: "How many young birds total?",
                                id: 4, //Prima era la domanda in posizione 4 quindi resta con questo ID
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        height: 0,
                        color: kColor1,
                      ),
                      Container(
                        color: Colors.transparent.withAlpha(0),
                        padding: EdgeInsets.only(
                            left: 15.w, right: 15.w, top: 45.h, bottom: 35.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                if (!isLoaded) {
                                  setState(() {
                                    pageController.animateToPage(
                                        currentIndex - 1,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.linear);
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/icon-back-form.svg",
                                    height: 14,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Back",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                if (!isLoaded) {
                                  setState(() {
                                    pageController.animateToPage(
                                        currentIndex + 1,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.linear);
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/icon-next-form.svg",
                                    height: 14,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // Positioned(
                  //     right: 0,
                  //     left: 0,
                  //     top: 25,
                  //     bottom: 10,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal:
                  //                   getProportionateScreenWidth(15)),
                  //           child: Container(
                  //             height: 110,
                  //             child: const heard2.CustomDropDownMenu(
                  //                 items: [
                  //                   'Family (Covey)',
                  //                   'Male',
                  //                   'Female',
                  //                   'Both'
                  //                 ]),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: getProportionateScreenHeight(10),
                  //         ),
                  //         const Divider(),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: getProportionateScreenWidth(15),
                  //               vertical: getProportionateScreenHeight(15)),
                  //           child: const NumericalQuestion(
                  //             title: "How many birds?",
                  //             id: 1,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: getProportionateScreenWidth(15),
                  //               vertical: getProportionateScreenHeight(15)),
                  //           child: const NumericalQuestion(
                  //             title: "How many male?",
                  //             id: 2,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: getProportionateScreenWidth(15),
                  //               vertical: getProportionateScreenHeight(15)),
                  //           child: const NumericalQuestion(
                  //               title: "How many female?", id: 3),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: getProportionateScreenWidth(15),
                  //               vertical: getProportionateScreenHeight(15)),
                  //           child: const NumericalQuestion(
                  //             title: "How many young birds?",
                  //             id: 4,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: getProportionateScreenWidth(15),
                  //               vertical: getProportionateScreenHeight(15)),
                  //           child: const NumericalQuestion(
                  //               title: "How many broods\nrappresented?",
                  //               id: 5),
                  //         ),
                  //         const Spacer(),
                  //         Container(
                  //           color: Colors.transparent,
                  //           padding: EdgeInsets.only(
                  //               left: getProportionateScreenWidth(15),
                  //               right: getProportionateScreenWidth(15),
                  //               bottom: getProportionateScreenHeight(10)),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             mainAxisAlignment:
                  //                 MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               TextButton(
                  //                 style: ButtonStyle(
                  //                   overlayColor: MaterialStateProperty.all(
                  //                       Colors.transparent),
                  //                   shadowColor: MaterialStateProperty.all(
                  //                       Colors.grey),
                  //                   backgroundColor:
                  //                       MaterialStateProperty.all(
                  //                           Colors.transparent),
                  //                 ),
                  //                 onPressed: () {
                  //                   if (!isLoaded) {
                  //                     setState(() {
                  //                       pageController.animateToPage(
                  //                           currentIndex - 1,
                  //                           duration:
                  //                               const Duration(seconds: 1),
                  //                           curve: Curves.linear);
                  //                     });
                  //                   }
                  //                 },
                  //                 child: Row(
                  //                   children: [
                  //                     SvgPicture.asset(
                  //                       "assets/icons/icon-back-form.svg",
                  //                       height:
                  //                           getProportionateScreenHeight(
                  //                               14),
                  //                     ),
                  //                     SizedBox(
                  //                       width:
                  //                           getProportionateScreenHeight(5),
                  //                     ),
                  //                     Text(
                  //                       "Back",
                  //                       style: TextStyle(
                  //                           fontSize:
                  //                               getProportionateScreenWidth(
                  //                                   14),
                  //                           color: kTextColor),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               const Spacer(),
                  //               TextButton(
                  //                 style: ButtonStyle(
                  //                   overlayColor: MaterialStateProperty.all(
                  //                       Colors.transparent),
                  //                   shadowColor: MaterialStateProperty.all(
                  //                       Colors.grey),
                  //                   backgroundColor:
                  //                       MaterialStateProperty.all(
                  //                           Colors.transparent),
                  //                 ),
                  //                 onPressed: () {
                  //                   if (!isLoaded) {
                  //                     setState(() {
                  //                       pageController.animateToPage(
                  //                           currentIndex + 1,
                  //                           duration:
                  //                               const Duration(seconds: 1),
                  //                           curve: Curves.linear);
                  //                     });
                  //                   }
                  //                 },
                  //                 child: Row(
                  //                   children: [
                  //                     Text(
                  //                       "Next",
                  //                       style: TextStyle(
                  //                           fontSize:
                  //                               getProportionateScreenWidth(
                  //                                   14),
                  //                           color: kTextColor),
                  //                     ),
                  //                     SizedBox(
                  //                       width:
                  //                           getProportionateScreenHeight(5),
                  //                     ),
                  //                     SvgPicture.asset(
                  //                       "assets/icons/icon-next-form.svg",
                  //                       height:
                  //                           getProportionateScreenHeight(
                  //                               14),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         const Spacer(),
                  //       ],
                  //     )),
                  //   ],
                  // ),
                  // Positioned(
                  //   right: 10.w,
                  //   left: 0,
                  //   top: 40.h,
                  //   child: SvgPicture.asset(
                  //     "assets/icons/mini-quail.svg",
                  //     height: 110.h,
                  //     alignment: Alignment.centerRight,
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 0.w,
                  //   left: 0.w,
                  //   top: 80.h,
                  //   child: Container(
                  //     color: Colors.transparent,
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const heard2.CustomDropDownMenu(
                  //             items: ['Family (Covey)', 'Individual bird']),
                  //         SizedBox(
                  //           height: 0.h,
                  //         ),
                  //         //const Divider(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage3(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      top: 23.h,
                    ),
                    child: Text(
                      "Register your sighting",
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                          fontSize: 21.sp),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: const heard3.CustomRadioButton(
                        items: {'Yes', 'No', '1', '2'},
                        title: "Did you want more information about Bobwhite?",
                        id: 1),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                    ),
                    child: const heard3.CustomRadioButton(
                        items: {'Yes', 'No', 'I\'m already\nenrolled', '1'},
                        title: "Want to learn more about Bobwhite Cost Share?",
                        id: 2),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const Divider(),
                  //_buildEmailForm(context),
                  // Divider(),
                  const CommentForm(),

                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(
                        left: 15.w, right: 15.w, top: 45.h, bottom: 35.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor: MaterialStateProperty.all(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            if (!isLoaded) {
                              setState(() {
                                pageController.animateToPage(currentIndex - 1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.linear);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/icon-back-form.svg",
                                height: 14,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          color: Colors.transparent,
                          width: (ScreenUtil().screenWidth) / 2 - 30.w,
                          child: DefaultButton(
                            text: "Send data",
                            press: () => _sendData(),
                            // press: () async {
                            //   // String name =
                            //   //     context.read<HeardPage1State>().name;
                            //   // String email =
                            //   //     context.read<HeardPage3State>().email;
                            //   // String time =
                            //   //     context.read<HeardPage1State>().time;
                            //   // String title =
                            //   //     context.read<HeardPage1State>().title;
                            //   // double latitude = context
                            //   //             .read<HeardPage1State>()
                            //   //             .latitude ==
                            //   //         ''
                            //   //     ? 1000
                            //   //     : double.parse(
                            //   //         context.read<HeardPage1State>().latitude);
                            //   // double longitude =
                            //   //     context.read<HeardPage1State>().longitude ==
                            //   //             ''
                            //   //         ? 1000
                            //   //         : double.parse(context
                            //   //             .read<HeardPage1State>()
                            //   //             .longitude);
                            //   // String date =
                            //   //     context.read<HeardPage1State>().date;
                            //   // String datetime = _buildDate(date, time);
                            //   // String physicallySee =
                            //   //     context.read<HeardPage1State>().physicallySee;
                            //   // String releasedLocation = context
                            //   //     .read<HeardPage1State>()
                            //   //     .releasedIntoLocation;
                            //   // String whatSee =
                            //   //     context.read<HeardPage2State>().whatSee;
                            //   // int manyBirds =
                            //   //     context.read<HeardPage2State>().totalCounter;
                            //   // int manyMale =
                            //   //     context.read<HeardPage2State>().maleCounter;
                            //   // int manyFemale =
                            //   //     context.read<HeardPage2State>().femaleCounter;
                            //   // int manyYoung =
                            //   //     context.read<HeardPage2State>().youngCounter;
                            //   // int manyBroods =
                            //   //     context.read<HeardPage2State>().broodsCounter;
                            //   // String moreInfo =
                            //   //     context.read<HeardPage3State>().moreInfo;
                            //   // String learnMore =
                            //   //     context.read<HeardPage3State>().learnMore;
                            //   // String comment =
                            //   //     context.read<HeardPage3State>().comment;

                            //   // bool checkNeeded =
                            //   //     context.read<HeardPage2State>().check;

                            //   // String locality = '';
                            //   // if (latitude != 1000) {
                            //   //   List<Placemark> placemarks =
                            //   //       await placemarkFromCoordinates(
                            //   //           latitude, longitude,
                            //   //           localeIdentifier: 'en_US');
                            //   //   locality = placemarks
                            //   //       .reversed.last.administrativeArea!;
                            //   // }

                            //   // print(locality);

                            //   // if (abbreviation
                            //   //     .containsKey(locality.toUpperCase())) {
                            //   //   locality =
                            //   //       abbreviation[locality.toUpperCase()]!;
                            //   // }
                            //   // locality =
                            //   //     locality.replaceAll(' ', '_').toLowerCase();

                            //   bool checkNeeded =
                            //       context.read<HeardPage2State>().check;

                            //   await _sendData();

                            //   if (!isLoaded) {
                            //     setState(() {
                            //       isLoaded = !isLoaded;
                            //     });
                            //     if (name != '' &&
                            //         _validateEmail(email) &&
                            //         latitude != 1000 &&
                            //         (manyBirds == manyFemale + manyMale ||
                            //             checkNeeded)) {
                            //       bool isSended =
                            //           await RemoteService().sendData(params);
                            //       if (isSended) {
                            //         await Future.delayed(Duration.zero, () {
                            //           context
                            //               .read<HeardPage3State>()
                            //               .resetAll();
                            //           context
                            //               .read<HeardPage1State>()
                            //               .resetAll();
                            //           context
                            //               .read<HeardPage2State>()
                            //               .resetAll();
                            //           Navigator.popAndPushNamed(context,
                            //               IHeardBobThanksScreen.routeName);
                            //         });
                            //       } else {
                            //         setState(() {
                            //           isLoaded = !isLoaded;
                            //         });
                            //         String message =
                            //             "A problem occurred while sending the data, please try again later.";
                            //         await Future.delayed(
                            //             Duration.zero,
                            //             () => showDialog(
                            //                 useSafeArea: false,
                            //                 context: context,
                            //                 builder: (BuildContext context) {
                            //                   Widget continueButton =
                            //                       TextButton(
                            //                     child: const Text(
                            //                       "OK",
                            //                       style: TextStyle(
                            //                           color: kTextColor),
                            //                     ),
                            //                     onPressed: () {
                            //                       Navigator.of(context).pop();
                            //                     },
                            //                   );
                            //                   AlertDialog alert = AlertDialog(
                            //                     backgroundColor: kColor3,
                            //                     title: Text(
                            //                       "Bobscapes",
                            //                       style: TextStyle(
                            //                           color: kTextColor,
                            //                           fontSize: 18.sp),
                            //                     ),
                            //                     content: Text(
                            //                       message,
                            //                       style: TextStyle(
                            //                           color: kTextColor,
                            //                           fontSize: 14.sp),
                            //                     ),
                            //                     actions: [
                            //                       continueButton,
                            //                     ],
                            //                   );
                            //                   return alert;
                            //                 }));
                            //       }
                            //     } else {
                            //       setState(() {
                            //         isLoaded = !isLoaded;
                            //       });

                            //       String message = _buildErrorMessage(name,
                            //           email, manyBirds, manyFemale, manyMale);

                            //       await Future.delayed(
                            //         Duration.zero,
                            //         () => showDialog(
                            //           useSafeArea: false,
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             Widget continueButton = TextButton(
                            //               child: const Text(
                            //                 "OK",
                            //                 style: TextStyle(color: kTextColor),
                            //               ),
                            //               onPressed: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //             );
                            //             AlertDialog alert = AlertDialog(
                            //               backgroundColor: kColor3,
                            //               title: Text(
                            //                 "Bobscapes",
                            //                 style: TextStyle(
                            //                     color: kTextColor,
                            //                     fontSize: 18.sp),
                            //               ),
                            //               content: Text(
                            //                 message,
                            //                 style: TextStyle(
                            //                     color: kTextColor,
                            //                     fontSize: 14.sp),
                            //               ),
                            //               actions: [
                            //                 continueButton,
                            //               ],
                            //             );
                            //             return alert;
                            //           },
                            //         ),
                            //       );
                            //     }
                            //   }
                            // },
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
  }

  String _buildErrorMessage(
      String name, String email, int manyBirds, int manyFemale, int manyMale) {
    String message = "You entered";
    String error = '';
    if (name == '' &&
        _validateEmail(email) &&
        manyBirds >= manyFemale + manyMale) {
      error = 'name';
    } else if (name != '' &&
        !_validateEmail(email) &&
        manyBirds >= manyFemale + manyMale) {
      error = 'email';
    } else if (name != '' &&
        _validateEmail(email) &&
        manyBirds < manyFemale + manyMale) {
      error = 'number of birds';
    } else if (name == '' &&
        !_validateEmail(email) &&
        manyBirds >= manyFemale + manyMale) {
      error = 'name and email';
    } else if (name == '' &&
        _validateEmail(email) &&
        manyBirds < manyFemale + manyMale) {
      error = 'name and number of birds';
    } else if (name != '' &&
        !_validateEmail(email) &&
        manyBirds < manyFemale + manyMale) {
      error = 'email and number of birds';
    } else {
      error = 'name, email and number of birds';
    }

    message = "$message $error incorrectly. Please try again.";
    // \nNote: Young birds and broods are not included in the total bird count and are considered a separate entity please try again.";

    return message;
  }

  dynamic _sendData() async {
    String name = context.read<HeardPage1State>().name;
    String email = context.read<HeardPage3State>().email;
    String time = context.read<HeardPage1State>().time;
    String title = context.read<HeardPage1State>().title;

    double latitude = context.read<HeardPage1State>().latitude == ''
        ? 1000
        : double.parse(context.read<HeardPage1State>().latitude);

    double longitude = context.read<HeardPage1State>().longitude == ''
        ? 1000
        : double.parse(context.read<HeardPage1State>().longitude);

    String date = context.read<HeardPage1State>().date;

    String physicallySee = context.read<HeardPage1State>().physicallySee;
    String releasedLocation =
        context.read<HeardPage1State>().releasedIntoLocation;
    String timeZone = context.read<HeardPage1State>().timeZone;
    String datetime = _buildDate(date, time, timeZone);

    int manyBirds = context.read<HeardPage2State>().totalCounter;
    int manyMale = context.read<HeardPage2State>().maleCounter;
    int manyFemale = context.read<HeardPage2State>().femaleCounter;
    int manyYoung = context.read<HeardPage2State>().youngCounter;
    int manyBroods = context.read<HeardPage2State>().broodsCounter;
    bool birdsCheck = context.read<HeardPage2State>().totalCheck;
    bool maleCheck = context.read<HeardPage2State>().maleCheck;
    bool femaleCheck = context.read<HeardPage2State>().femaleCheck;
    bool youngCheck = context.read<HeardPage2State>().youngCheck;
    bool broodsCheck = context.read<HeardPage2State>().broodsCheck;

    String moreInfo = context.read<HeardPage3State>().moreInfo;
    String learnMore = context.read<HeardPage3State>().learnMore;
    String comment = context.read<HeardPage3State>().comment;

    bool checkNeeded = context.read<HeardPage2State>().check;

    String locality = '';
    if (latitude != 1000) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude,
          localeIdentifier: 'en_US');
      locality = placemarks.reversed.last.administrativeArea!;
    }

    print(locality);

    if (abbreviation.containsKey(locality.toUpperCase())) {
      locality = abbreviation[locality.toUpperCase()]!;
    }
    locality = locality.replaceAll(' ', '_').toLowerCase();

    params = {
      "name": name,
      "email": email,
      "title": title,
      "latitude": latitude,
      "longitude": longitude,
      "datetime": datetime,
      "timeZone": timeZone,
      "physicallySee": physicallySee,
      "releasedLocation": releasedLocation,
      //  "whatSee": whatSee,
      "manyBirds": manyBirds,
      "manyMale": manyMale,
      "manyFemale": manyFemale,
      "manyYoung": manyYoung,
      "manyBroods": manyBroods,
      "birdsCheck": birdsCheck,
      "maleCheck": maleCheck,
      "femaleCheck": femaleCheck,
      "youngCheck": youngCheck,
      "broodsCheck": broodsCheck,
      "moreInformation": moreInfo,
      "learnMore": learnMore,
      "comment": comment,
      "state": locality
    };

    if (!isLoaded) {
      setState(() {
        isLoaded = !isLoaded;
      });
      if (name != '' &&
          _validateEmail(email) &&
          latitude != 1000 &&
          (manyBirds >= manyFemale + manyMale)) {
        bool isSended = await RemoteService().sendData(params);
        if (isSended) {
          await Future.delayed(Duration.zero, () {
            context.read<HeardPage3State>().resetAll();
            context.read<HeardPage1State>().resetAll();
            context.read<HeardPage2State>().resetAll();
            Navigator.popAndPushNamed(context, IHeardBobThanksScreen.routeName);
          });
        } else {
          setState(() {
            isLoaded = !isLoaded;
          });
          String message =
              "A problem occurred while sending the data, please try again later.";
          await Future.delayed(
              Duration.zero,
              () => showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (BuildContext context) {
                    Widget continueButton = TextButton(
                      child: const Text(
                        "OK",
                        style: TextStyle(color: kTextColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      backgroundColor: kColor3,
                      title: Text(
                        "Bobscapes",
                        style: TextStyle(color: kTextColor, fontSize: 18.sp),
                      ),
                      content: Text(
                        message,
                        style: TextStyle(color: kTextColor, fontSize: 14.sp),
                      ),
                      actions: [
                        continueButton,
                      ],
                    );
                    return alert;
                  }));
        }
      } else {
        setState(() {
          isLoaded = !isLoaded;
        });

        String message =
            _buildErrorMessage(name, email, manyBirds, manyFemale, manyMale);

        await Future.delayed(
          Duration.zero,
          () => showDialog(
            useSafeArea: false,
            context: context,
            builder: (BuildContext context) {
              Widget continueButton = TextButton(
                child: const Text(
                  "OK",
                  style: TextStyle(color: kTextColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
              AlertDialog alert = AlertDialog(
                backgroundColor: kColor3,
                title: Text(
                  "Bobscapes",
                  style: TextStyle(color: kTextColor, fontSize: 18.sp),
                ),
                content: Text(
                  message,
                  style: TextStyle(color: kTextColor, fontSize: 14.sp),
                ),
                actions: [
                  continueButton,
                ],
              );
              return alert;
            },
          ),
        );
      }
    }
  }

  bool _validateEmail(String email) {
    return emailValidatorRegExp.hasMatch(email);
  }

  String _buildDate(String date, String time, String timeZone) {
    // date = date.replaceAll('\'', '20');
    date = '${date.substring(0, 6)}20${date.substring(6)}';

    DateTime d = DateFormat.yMd().parse(date);
    DateTime t = DateFormat.jm().parse(time);

    int hours = 5;
    switch (timeZone) {
      case 'Central (CST)':
        hours = 6;
        break;
      case 'Mountain (MST)':
        hours = 7;
        break;
      case 'Pacific (PST)':
        hours = 8;
        break;
      // case 'Alaska (UTC -9H)':
      //   hours = 9;
      //   break;
      // case 'Hawaii-Aleutian (UTC -10H)':
      //   hours = 10;
      //   break;
    }

    t = t.add(Duration(hours: hours));

    DateTime dt = DateTime(
      d.year,
      d.month,
      d.day,
      t.hour,
      t.minute,
    );

    String dts = dt.toString().substring(0, 19);

    return dts;
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
        overlayColor: MaterialStateProperty.all(kAppbarColor),
        shadowColor: MaterialStateProperty.all(Colors.grey),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 48.h),
        ),
        backgroundColor: MaterialStateProperty.all(kAppbarColor),
      ),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              color: kTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          SvgPicture.asset(
            "assets/icons/icon-arrow.svg",
            height: 14,
          ),
        ],
      ),
    );
  }
}
