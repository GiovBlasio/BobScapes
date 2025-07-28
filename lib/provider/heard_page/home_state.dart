import 'package:flutter/cupertino.dart';

class HomeState with ChangeNotifier {
  bool _firstAccess = true;

  bool get firstAccess => _firstAccess;

  void changeFirstAccess() {
    _firstAccess = false;
    notifyListeners();
  }
}
