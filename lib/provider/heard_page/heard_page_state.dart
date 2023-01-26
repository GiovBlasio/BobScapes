import 'package:bobscapes/views/i_heard_bob/components/heard_page1.dart';
import 'package:flutter/cupertino.dart';

import '../../size_config.dart';

class HeardPageState with ChangeNotifier {
  Widget _page = const HeardPage1();
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
