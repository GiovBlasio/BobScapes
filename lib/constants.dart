import 'package:flutter/material.dart';
import 'size_config.dart';

const kColor1 = Color(0xFFFAA11C);
const kColor2 = Color(0xFFE57823);
const kColor3 = Color(0xFFA84E47);

const kPrimaryColor = Color(0xff2c2c2c);
const kPrimaryLightColor = Color(0xffece0d0);
const kSecondaryColor = Color(0x772c2c2c);
const kTextColor = Color(0xff2c2c2c);
const kTextLightColor = Color(0xFF666362);
const kAppbarColor = Color(0x33c2c2c2);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff2c2c2c),
    Color(0xffece0d0),
  ],
);

const kDefaultPaddin = 20.0;
const kAnimationDuration = Duration(milliseconds: 200);

TextStyle headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Per favore, inserisci la tua email";
const String kInvalidEmailError = "Per favore, inserisci un'email valida";

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
