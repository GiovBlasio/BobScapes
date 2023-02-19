import 'package:flutter/cupertino.dart';

import '../../size_config.dart';

class HeardPageState with ChangeNotifier {
  Widget _page = Container();
  double _top = getProportionateScreenHeight(60);

  Widget get page => _page;
  double get top => _top;

  void changePage(Widget newPage) {
    _page = newPage;
    notifyListeners();
  }

  void changeTop(double newTop) {
    _top = newTop;
    notifyListeners();
  }
}
