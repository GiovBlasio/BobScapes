import 'package:flutter/widgets.dart';

import 'views/home/home.dart';
import 'views/welcome/welcome.dart';
import 'views/i_heard_bob/i_heard_bob.dart';
import 'views/i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import 'views/bob_sightings/bob_sightings.dart';
import 'views/hear_bob/hear_bob.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  IHeardBobScreen.routeName: (context) => const IHeardBobScreen(),
  IHeardBobThanksScreen.routeName: (context) => const IHeardBobThanksScreen(),
  HearBobScreen.routeName: (context) => const HearBobScreen(),
  BobSightingsScreen.routeName: (context) => const BobSightingsScreen(),
};
