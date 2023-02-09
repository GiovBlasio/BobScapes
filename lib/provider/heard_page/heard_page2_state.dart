import 'package:flutter/cupertino.dart';

class HeardPage2State with ChangeNotifier {
  int _maleCounter = 0;
  int _femaleCounter = 0;
  int _youngCounter = 0;
  int _totalCounter = 0;
  int _broodsCounter = 0;
  String _whatSee = 'Family (Covey)';

  int get total => _maleCounter + _femaleCounter;
  int get maleCounter => _maleCounter;
  int get femaleCounter => _femaleCounter;
  int get youngCounter => _youngCounter;
  int get totalCounter => _totalCounter;
  int get broodsCounter => _broodsCounter;
  String get whatSee => _whatSee;

  void changeWhatSee(String value) {
    _whatSee = value;
    notifyListeners();
  }

  void incrementBroodsCounter() {
    if (broodsCounter < _youngCounter) {
      _broodsCounter++;
    }
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
    if (total < _totalCounter) {
      _totalCounter--;
    }
    notifyListeners();
  }

  void incrementMaleCounter() {
    if (total < _totalCounter) {
      _maleCounter++;
    }
    notifyListeners();
  }

  void incrementFemaleCounter() {
    if (total < _totalCounter) {
      _femaleCounter++;
    }
    notifyListeners();
  }

  void incrementYoungCounter() {
    if (_youngCounter < _totalCounter) {
      _youngCounter++;
    }
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
    notifyListeners();
  }
}
