import 'package:flutter/cupertino.dart';

class EmailEnabler with ChangeNotifier {
  bool _moreInformationIsTrue = true;
  bool _learnMoreIsTrue = true;
  String _moreInfoValue = 'Yes';
  String _learnMoreValue = 'Yes';
  String _email = '';
  String _comment = '';

  String get learnMore => _learnMoreValue;
  String get moreInfo => _moreInfoValue;
  bool get isEnable => _moreInformationIsTrue || _learnMoreIsTrue;
  String get email => _email;
  String get comment => _comment;

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void changeComment(String value) {
    _comment = value;
    notifyListeners();
  }

  void changeMoreInfoValue(String value) {
    _moreInfoValue = value;
    notifyListeners();
  }

  void changeLearnMoreValue(String value) {
    _learnMoreValue = value;
    notifyListeners();
  }

  void enablingMoreInformation(String value) {
    if (value != 'Yes') {
      falsedMoreInformation();
    } else {
      truedMoreInformation();
    }
    notifyListeners();
  }

  void enablingLearnMore(String value) {
    if (value != 'Yes') {
      falsedLearnMore();
    } else {
      truedLearnMore();
    }
    notifyListeners();
  }

  void truedMoreInformation() {
    _moreInformationIsTrue = true;
    notifyListeners();
  }

  void falsedMoreInformation() {
    _moreInformationIsTrue = false;
    notifyListeners();
  }

  void truedLearnMore() {
    _learnMoreIsTrue = true;
    notifyListeners();
  }

  void falsedLearnMore() {
    _learnMoreIsTrue = false;
    notifyListeners();
  }

  void resetAll() {
    _moreInformationIsTrue = true;
    _learnMoreIsTrue = true;
    _moreInfoValue = 'Yes';
    _learnMoreValue = 'Yes';
    _email = '';
    _comment = '';
    notifyListeners();
  }
}
