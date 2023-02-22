import 'package:flutter/cupertino.dart';

class HeardPage2State with ChangeNotifier {
  int _maleCounter = 0;
  int _femaleCounter = 0;
  int _youngCounter = 0;
  int _totalCounter = 0;
  int _broodsCounter = 0;
  String _whatSee = 'Family (Covey)';
  bool _maleCheck = true;
  bool _femaleCheck = true;
  bool _youngCheck = true;
  bool _totalCheck = true;
  bool _broodsCheck = true;

  int get total => _maleCounter + _femaleCounter;
  int get maleCounter => _maleCounter;
  int get femaleCounter => _femaleCounter;
  int get youngCounter => _youngCounter;
  int get totalCounter => _totalCounter;
  int get broodsCounter => _broodsCounter;
  String get whatSee => _whatSee;
  bool get maleCheck => _maleCheck;
  bool get femaleCheck => _femaleCheck;
  bool get youngCheck => _youngCheck;
  bool get totalCheck => _totalCheck;
  bool get broodsCheck => _broodsCheck;
  bool get check =>
      _youngCheck || _maleCheck || _broodsCheck || _totalCheck || _femaleCheck;

  void changeWhatSee(String value) {
    _whatSee = value;
    notifyListeners();
  }

  void changeBroodsCheck() {
    _broodsCheck = !_broodsCheck;
    notifyListeners();
  }

  void changeMaleCheck() {
    _maleCheck = !_maleCheck;
    notifyListeners();
  }

  void changeFemaleCheck() {
    _femaleCheck = !_femaleCheck;
    notifyListeners();
  }

  void changeYoungCheck() {
    _youngCheck = !_youngCheck;
    notifyListeners();
  }

  void changeTotalCheck() {
    _totalCheck = !_totalCheck;
    notifyListeners();
  }

  void incrementBroodsCounter() {
    _broodsCounter++;

    notifyListeners();
  }

  void decrementBroodsCounter() {
    broodsCounter > 0 ? _broodsCounter-- : _broodsCounter;
    notifyListeners();
  }

  void incrementTotalCounter() {
    _totalCounter++;
    notifyListeners();
  }

  void decrementTotalCounter() {
    if (total < _totalCounter || check) {
      _totalCounter--;
    }
    notifyListeners();
  }

  void incrementMaleCounter() {
    if (total < _totalCounter || check) {
      _maleCounter++;
    }
    notifyListeners();
  }

  void incrementFemaleCounter() {
    if (total < _totalCounter || check) {
      _femaleCounter++;
    }
    notifyListeners();
  }

  void incrementYoungCounter() {
    _youngCounter++;

    notifyListeners();
  }

  void decrementMaleCounter() {
    _maleCounter > 0 ? _maleCounter-- : _maleCounter;
    notifyListeners();
  }

  void decrementFemaleCounter() {
    _femaleCounter > 0 ? _femaleCounter-- : _femaleCounter;
    notifyListeners();
  }

  void decrementYoungCounter() {
    _youngCounter > 0 ? _youngCounter-- : _youngCounter;
    notifyListeners();
  }

  void resetAll() {
    _maleCounter = 0;
    _femaleCounter = 0;
    _youngCounter = 0;
    _totalCounter = 0;
    _broodsCounter = 0;
    _whatSee = 'Family (Covey)';
    _maleCheck = true;
    _femaleCheck = true;
    _youngCheck = true;
    _totalCheck = true;
    _broodsCheck = true;
    notifyListeners();
  }
}
