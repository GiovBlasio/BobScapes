import 'package:flutter/cupertino.dart';

class HeardPage1State with ChangeNotifier {
  String _name = '';
  String _type = 'Landowner';
  // String _latitude = '';
  // String _longitude = '';
  String _location = '';
  String _date = '';
  String _time = '';
  String _releasedIntoLocation = 'Yes';
  String _physicallySee = 'Yes';

  String get releasedIntoLocation => _releasedIntoLocation;
  String get physicallySee => _physicallySee;
  String get time => _time;
  String get date => _date;
  // String get longitude => _longitude;
  // String get latitude => _latitude;
  String get type => _type;
  String get name => _name;

  String get location => _location;

  void changeName(String value) {
    _name = value;
    notifyListeners();
  }

  void changeTime(String value) {
    _time = value;
    notifyListeners();
  }

  void changeLocation(String value) {
    _location = value;
    notifyListeners();
  }

  // void changeLatitude(String value) {
  //   _latitude = value;
  //   notifyListeners();
  // }

  // void changeLongitude(String value) {
  //   _longitude = value;
  //   notifyListeners();
  // }

  void changeDate(String value) {
    _date = value;
    notifyListeners();
  }

  void changeType(String value) {
    _type = value;
    notifyListeners();
  }

  void changeReleasedLocation(String value) {
    _releasedIntoLocation = value;
    notifyListeners();
  }

  void changePhysicallySee(String value) {
    _physicallySee = value;
    notifyListeners();
  }

  void resetAll() {
    _name = '';
    _type = 'Landowner';
    // String _latitude = '';
    // String _longitude = '';
    _location = '';
    _date = '';
    _time = '';
    _releasedIntoLocation = 'Yes';
    _physicallySee = 'Yes';
  }
}
