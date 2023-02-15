import 'package:bobscapes/services/remote_services.dart';
import 'package:bobscapes/views/common_widget/bottom_buttons.dart';
import 'package:bobscapes/views/common_widget/custom_title.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/bob_sightings.dart';
import 'package:bobscapes/views/hear_bob/hear_bob.dart';
import 'package:bobscapes/views/i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'heard_page1/custom_forms.dart';
import 'heard_page1/custom_radio_button.dart';
import 'heard_page1/location_form.dart';
import 'heard_page1/personal_info.dart';
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
  PageController pageController = PageController();

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

  late bool isEnabled = true;

  final _keyEmail = GlobalKey<FormState>();

  final _keyName = GlobalKey<FormState>();

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  void changeName(String name) {
    context.read<HeardPage1State>().changeName(name);
  }

  void changeEmail(String email) {
    context.read<HeardPage3State>().changeEmail(email);
  }

  void _initialization() {
    isEnabled = Provider.of<HeardPage3State>(context, listen: false).isEnable;

    String name = Provider.of<HeardPage1State>(context, listen: false).name;

    String email = Provider.of<HeardPage3State>(context, listen: false).email;

    if (email != '' && isEnabled) {
      emailController = TextEditingController(text: email);
    }
    if (name != '') controller = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset("assets/images/sfondo3.svg",
              fit: BoxFit.cover, width: double.infinity),
        ),
        Positioned(
          bottom: getProportionateScreenHeight(0),
          top: getProportionateScreenHeight(50),
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
                _buildPage2(),
                _buildPage3(context),
              ]),
        ),
        Positioned(
            height: getProportionateScreenHeight(50),
            width: SizeConfig.screenWidth,
            child: const CustomTitle(
              title: "I Heard a Bob!",
              color: kColor2,
              icon: "assets/icons/gps.svg",
            )),
        Positioned(
            bottom: 0,
            child: Row(
              children: [
                BottomButton(
                  color: kColor3,
                  title: "Bob Sightings Map",
                  iconPath: "assets/icons/eye.svg",
                  onPressed: () => Navigator.popAndPushNamed(
                      context, BobSightingsScreen.routeName),
                ),
                BottomButton(
                  color: kColor1,
                  title: "Hear Bob",
                  iconPath: "assets/icons/music.svg",
                  onPressed: () => Navigator.popAndPushNamed(
                      context, HearBobScreen.routeName),
                ),
              ],
            )),
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

  Scaffold _buildPage3(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenHeight(0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 15, bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Register your sighting",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kTextColor,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const heard3.CustomRadioButton(
                        items: {'Yes', 'No', '1', '2'},
                        title: "Did you want more information about Bobwhite?",
                        id: 1),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    const heard3.CustomRadioButton(
                        items: {'Yes', 'No', 'I\'m alredy\nregistered', '1'},
                        title: "Want to learn more about Bobwhite Cost Share?",
                        id: 2),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    _buildEmailForm(context),
                    Divider(),
                    const CommentForm(),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.grey),
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
                                  height: getProportionateScreenHeight(14),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(5),
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14),
                                      color: kTextColor),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            color: Colors.transparent,
                            width: (SizeConfig.screenWidth) / 2 -
                                getProportionateScreenWidth(30),
                            child: DefaultButton(
                                text: "Send data",
                                press: () async {
                                  String name =
                                      context.read<HeardPage1State>().name;
                                  String email =
                                      context.read<HeardPage3State>().email;
                                  String time =
                                      context.read<HeardPage1State>().time;
                                  String title =
                                      context.read<HeardPage1State>().title;
                                  double latitude = context
                                              .read<HeardPage1State>()
                                              .latitude ==
                                          ''
                                      ? 1000
                                      : double.parse(context
                                          .read<HeardPage1State>()
                                          .latitude);
                                  double longitude = context
                                              .read<HeardPage1State>()
                                              .longitude ==
                                          ''
                                      ? 1000
                                      : double.parse(context
                                          .read<HeardPage1State>()
                                          .longitude);

                                  String date =
                                      context.read<HeardPage1State>().date;

                                  String datetime = _buildDate(date, time);
                                  String physicallySee = context
                                      .read<HeardPage1State>()
                                      .physicallySee;
                                  String releasedLocation = context
                                      .read<HeardPage1State>()
                                      .releasedIntoLocation;
                                  String whatSee =
                                      context.read<HeardPage2State>().whatSee;
                                  int manyBirds = context
                                      .read<HeardPage2State>()
                                      .totalCounter;
                                  int manyMale = context
                                      .read<HeardPage2State>()
                                      .maleCounter;
                                  int manyFemale = context
                                      .read<HeardPage2State>()
                                      .femaleCounter;
                                  int manyYoung = context
                                      .read<HeardPage2State>()
                                      .youngCounter;
                                  int manyBroods = context
                                      .read<HeardPage2State>()
                                      .broodsCounter;

                                  String moreInfo =
                                      context.read<HeardPage3State>().moreInfo;
                                  String learnMore =
                                      context.read<HeardPage3State>().learnMore;
                                  String comment =
                                      context.read<HeardPage3State>().comment;
                                  String locality = '';
                                  if (latitude != 1000) {
                                    List<Placemark> placemarks =
                                        await placemarkFromCoordinates(
                                            latitude, longitude);

                                    locality = placemarks
                                        .reversed.last.administrativeArea!;
                                  }

                                  // name.replaceAll("'", "'\\''");

                                  // print(name);

                                  // locality =
                                  //     locality.substring(0, 1).toUpperCase() +
                                  //         locality.substring(1);

                                  Map<String, dynamic> params = {
                                    "name": name,
                                    "email": email,
                                    "title": title,
                                    "latitude": latitude,
                                    "longitude": longitude,
                                    "datetime": datetime,
                                    "physicallySee": physicallySee,
                                    "releasedLocation": releasedLocation,
                                    "whatSee": whatSee,
                                    "mayBirds": manyBirds,
                                    "manyMale": manyMale,
                                    "manyFemale": manyFemale,
                                    "manyYoung": manyYoung,
                                    "manyBroods": manyBroods,
                                    "moreInformation": moreInfo,
                                    "learnMore": learnMore,
                                    "comment": comment,
                                    "state": locality
                                  };

                                  if (!isLoaded) {
                                    setState(() {
                                      isLoaded = !isLoaded;
                                    });

                                    if (_keyEmail.currentState != null &&
                                        _keyEmail.currentState!.validate() &&
                                        name != '' &&
                                        latitude != 1000 &&
                                        manyBirds == manyFemale + manyMale) {
                                      bool isSended = await RemoteService()
                                          .sendData(params);
                                      if (isSended) {
                                        setState(() {
                                          context
                                              .read<HeardPage3State>()
                                              .resetAll();
                                          context
                                              .read<HeardPage1State>()
                                              .resetAll();
                                          context
                                              .read<HeardPage2State>()
                                              .resetAll();

                                          Navigator.popAndPushNamed(context,
                                              IHeardBobThanksScreen.routeName);
                                        });
                                      } else {
                                        setState(() {
                                          isLoaded = !isLoaded;
                                        });
                                        await Future.delayed(
                                            Duration.zero,
                                            () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  Widget continueButton =
                                                      TextButton(
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: kTextColor),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    backgroundColor: kColor3,
                                                    title: Text(
                                                      "Bobscapes",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  18)),
                                                    ),
                                                    content: Text(
                                                      "A problem occurred while sending the data, please try again later.",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14)),
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
                                      await Future.delayed(
                                          Duration.zero,
                                          () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Widget continueButton =
                                                    TextButton(
                                                  child: const Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: kTextColor),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                                AlertDialog alert = AlertDialog(
                                                  backgroundColor: kColor3,
                                                  title: Text(
                                                    "Bobscapes",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                18)),
                                                  ),
                                                  content: Text(
                                                    "You entered your name, number of birds or email incorrectly, please try again.",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                14)),
                                                  ),
                                                  actions: [
                                                    continueButton,
                                                  ],
                                                );

                                                return alert;
                                              }));
                                    }
                                  }
                                }),
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
      ),
    );
  }

  Padding _buildEmailForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Form(
        key: _keyEmail,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: context.watch<HeardPage3State>().isEnable
                        ? kTextColor
                        : kTextColor.withOpacity(0.6),
                    fontWeight: FontWeight.w400),
                children: [
                  const TextSpan(text: 'Your email '),
                  if (context.watch<HeardPage3State>().isEnable)
                    const TextSpan(
                        text: '(required)',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: kTextColor)),
                ],
              ),
            ),
            Flexible(
              child: TextFormField(
                style: const TextStyle(
                    color: kTextColor, fontWeight: FontWeight.w500),
                enableInteractiveSelection: false,
                cursorColor: kTextColor,
                enabled: context.watch<HeardPage3State>().isEnable,
                keyboardType: TextInputType.emailAddress,
                controller: context.watch<HeardPage3State>().isEnable
                    ? emailController
                    : TextEditingController(text: ''),
                onChanged: (value) {
                  changeEmail(value);
                },
                validator: (value) {
                  if (!_validateEmail(value!) &&
                      Provider.of<HeardPage3State>(context, listen: false)
                          .isEnable) {
                    return 'Enter correct email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabled: context.watch<HeardPage3State>().isEnable,
                  labelStyle: TextStyle(
                      color: context.watch<HeardPage3State>().isEnable
                          ? kTextColor
                          : null,
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w500),
                  hintStyle: TextStyle(
                      color: context.watch<HeardPage3State>().isEnable
                          ? kTextColor.withOpacity(0.6)
                          : null,
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w300),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.all(
                    getProportionateScreenWidth(8),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
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
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(5)),
                    child: SvgPicture.asset(
                      "assets/icons/icon-mail.svg",
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: getProportionateScreenHeight(28),
                      maxWidth: getProportionateScreenWidth(28)),
                  hintText: "hello@aol.com",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 65, top: 0),
              child: Stack(
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8, left: 15, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Register your sighting",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //  const Divider(
                    //         height: 0,
                    //         color: kColor1,
                    //         thickness: 1,
                    //       ),
                    Container(
                      // color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Form(
                              key: _keyName,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                controller: controller,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  changeName(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "Enter correct name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: kTextColor,
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.w500),
                                  hintStyle: TextStyle(
                                    color: kTextColor.withAlpha(177),
                                    fontSize: getProportionateScreenWidth(12),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          getProportionateScreenHeight(8)),
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
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: "Your name (required)",
                                  hintText: "Shane Mahoney",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomDropDownMenu(items: itemsPage1),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    //  const Divider(
                    //         height: 0,
                    //         color: kColor1,
                    //         thickness: 1,
                    //       ),
                    SizedBox(
                      height: 20,
                    ),
                    const LocationForm(),
                    SizedBox(
                      height: 10,
                    ),
                    const DateAndTimeForm(),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(15),
                          left: getProportionateScreenWidth(15)),
                      child: CustomRadioButton(
                          items: radioOptionsPage1,
                          title:
                              "Are bobwhites released at the sightings location?",
                          id: 1),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(8),
                          left: getProportionateScreenWidth(15)),
                      child: CustomRadioButton(
                          items: radioOptions2Page1,
                          title: "Did you physically see any birds?",
                          id: 2),
                    ),
                    Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(15),
                          right: getProportionateScreenWidth(15),
                        ),
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
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: kTextColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
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
                  ]),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/icons/mini-quail.svg",
                        height: 100,
                        alignment: Alignment.centerRight,
                      )),
                  Positioned(
                    top: 68,
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
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15)),
                            child: Form(
                              // key: _keyName,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                controller: controller,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  changeName(value);
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "Enter correct name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: kTextColor,
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.w500),
                                  hintStyle: TextStyle(
                                    color: kTextColor.withAlpha(177),
                                    fontSize: getProportionateScreenWidth(12),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical:
                                          getProportionateScreenHeight(8)),
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
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                  labelText: "Your name (required)",
                                  hintText: "Shane Mahoney",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomDropDownMenu(items: itemsPage1),
                          SizedBox(
                            height: 20,
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
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Flexible(
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(70), top: 0),
                  child: Stack(children: [
                    Container(
                      height: SizeConfig.screenHeight -
                          getProportionateScreenHeight(201),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(15),
                                top: getProportionateScreenHeight(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Register your sighting",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kTextColor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(15)),
                                child: Container(
                                  height: 65,
                                  // child: const heard2.CustomDropDownMenu(items: [
                                  //   'Family (Covey)',
                                  //   'Male',
                                  //   'Female',
                                  //   'Both'
                                  // ]),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              const Divider(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(15),
                                    vertical: getProportionateScreenHeight(15)),
                                child: const NumericalQuestion(
                                  title: "How many birds?",
                                  id: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(15),
                                    vertical: getProportionateScreenHeight(15)),
                                child: const NumericalQuestion(
                                  title: "How many male?",
                                  id: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(15),
                                    vertical: getProportionateScreenHeight(15)),
                                child: const NumericalQuestion(
                                    title: "How many female?", id: 3),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(15),
                                    vertical: getProportionateScreenHeight(15)),
                                child: const NumericalQuestion(
                                  title: "How many young birds?",
                                  id: 4,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(15),
                                    vertical: getProportionateScreenHeight(15)),
                                child: const NumericalQuestion(
                                    title: "How many broods\nrappresented?",
                                    id: 5),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(15),
                                right: getProportionateScreenWidth(15)),
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
                                            duration:
                                                const Duration(seconds: 1),
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
                                        width: 5,
                                      ),
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                            fontSize: 14, color: kTextColor),
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
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.linear);
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                            fontSize: 14, color: kTextColor),
                                      ),
                                      SizedBox(
                                        width: 5,
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
                        ],
                      ),
                    ),
                    Positioned(
                        right: 0,
                        left: 0,
                        top: 15,
                        child: SvgPicture.asset(
                          "assets/icons/mini-quail.svg",
                          height: 100,
                          alignment: Alignment.centerRight,
                        )),
                    Positioned(
                      right: 15,
                      left: 15,
                      top: 55,
                      child: Container(
                        height: 110,
                        child: const heard2.CustomDropDownMenu(items: [
                          'Family (Covey)',
                          'Male',
                          'Female',
                          'Both'
                        ]),
                      ),
                    ),
                  ])))
        ]));
  }

  bool _validateEmail(String email) {
    return emailValidatorRegExp.hasMatch(email);
  }

  String _buildDate(String date, String time) {
    date = date.replaceAll('\'', '20');

    DateTime d = DateFormat.yMd().parse(date);
    DateTime t = DateFormat.jm().parse(time);
    DateTime dt = DateTime.utc(d.year, d.month, d.day, t.hour, t.minute);

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
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        minimumSize: MaterialStateProperty.all(
            Size(double.infinity, getProportionateScreenHeight(44))),
        backgroundColor: MaterialStateProperty.all(kAppbarColor),
      ),
      onPressed: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                color: kPrimaryColor),
          ),
          SizedBox(
            width: getProportionateScreenHeight(5),
          ),
          SvgPicture.asset(
            "assets/icons/icon-arrow.svg",
            height: getProportionateScreenHeight(14),
          ),
        ],
      ),
    );
  }
}
