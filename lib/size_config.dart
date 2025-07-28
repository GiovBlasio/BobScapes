import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation orientation = Orientation.portrait;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //812.0 è l'altezza del layout utilizzato dal designer
  return (inputHeight / 756.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  //375.0 è la larghezza del layout utilizzato dal designer
  return (inputWidth / 360.0) * screenWidth;
}

