import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'size_config.dart';

// const kColor1 = Color(0xFFFAA11C);
// const kColor2 = Color(0xFFE57823);
// const kColor3 = Color(0xFFA84E47);

const kColor1 = Color(0xFFFF9B00);
const kColor2 = Color(0xFFFCF5A9);
const kColor3 = Color(0xFFFFFFFF);
const kTextColor = Color(0xFF552D00);
const kTextLightColor = Color(0xFF7D6042);
const kAppbarColor = Color(0xFFFFE439);

const kPrimaryColor = Color(0xff2c2c2c);
const kPrimaryLightColor = Color(0xffece0d0);
const kSecondaryColor = Color(0x772c2c2c);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff2c2c2c),
    Color(0xffece0d0),
  ],
);

Map<String, LatLng> state = {
  'Alabama': LatLng(32.3668052, -86.2999689),
  'Alaska': LatLng(58.301944, -134.419722),
  'Arizona': LatLng(33.448377, -112.074037),
  'Arkansas': LatLng(34.746481, -92.289595),
  'California': LatLng(38.590576, -121.489906),
  'North Carolina': LatLng(35.884766, -78.625053),
  'Sud Carolina': LatLng(34.000333332, -81.039833174),
  'Colorado': LatLng(39.742043, -104.991531),
  'Connecticut': LatLng(41.763710, -72.685097),
  'Delaware': LatLng(39.157307, -75.519722),
  'Hawaii': LatLng(21.307442, -157.857376),
  'Florida': LatLng(30.438118, -84.281296),
  'Georgia': LatLng(33.749027, -84.388229),
  'Idaho': LatLng(43.617775, -116.199722),
  'Illinois': LatLng(39.798363, -89.654961),
  'Indiana': LatLng(39.768623, -86.162643),
  'Iowa': LatLng(41.591087, -93.603729),
  'Kansas': LatLng(39.048191, -95.677956),
  'Kentucky': LatLng(38.186722, -84.875374),
  'Louisiana': LatLng(30.457069, -91.187393),
  'Maine': LatLng(44.307167, -69.781693),
  'Maryland': LatLng(38.978764, -76.490936),
  'Massachusetts': LatLng(42.358162, -71.063698),
  'Michigan': LatLng(42.733635, -84.555328),
  'Minnesota': LatLng(44.955097, -93.102211),
  'Mississippi': LatLng(32.303848, -90.182106),
  'Missouri': LatLng(38.579201, -92.172935),
  'Montana': LatLng(46.585709, -112.018417),
  'Nebraska': LatLng(40.808075, -96.699654),
  'Nevada': LatLng(39.163914, -119.766121),
  'New Hampshire': LatLng(43.206898, -71.537994),
  'New Jersey': LatLng(40.220596, -74.769913),
  'New Mexico': LatLng(35.68224, -105.939728),
  'North Dakota': LatLng(46.82085, -100.783318),
  'New York': LatLng(42.652843, -73.757874),
  'Ohio': LatLng(39.961346, -82.999069),
  'Oklahoma': LatLng(35.492207, -97.503342),
  'Oregon': LatLng(44.938461, -123.030403),
  'Pennsylvania': LatLng(40.264378, -76.883598),
  'Rhode Island': LatLng(41.830914, -71.414963),
  'Sud Dakota': LatLng(44.367031, -100.346405),
  'Tennessee': LatLng(36.16581, -86.784241),
  'Texas': LatLng(30.27467, -97.740349),
  'Utah': LatLng(40.777477, -111.888237),
  'Vermont': LatLng(44.262436, -72.580536),
  'Virginia': LatLng(37.538857, -77.43364),
  'Washington': LatLng(47.035805, -122.905014),
  'West Virginia': LatLng(38.336246, -81.612328),
  'Wisconsin': LatLng(43.074684, -89.384445),
  'Wyoming': LatLng(41.140259, -104.820236)
};

const kDefaultPaddin = 20.0;
const kAnimationDuration = Duration(milliseconds: 200);

TextStyle headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
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
