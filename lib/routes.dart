import 'package:bobscapes/views/2_welcome/welcome.dart';
import 'package:flutter/widgets.dart';

import 'views/3_home/home.dart';
import 'views/1_splash/splash.dart';
import 'views/5_i_heard_bob/i_heard_bob.dart';
import 'views/6_i_heard_bob_thanks/i_heard_bob_thanks_screen.dart';
import 'views/7_bob_sightings/bob_sightings.dart';
import 'views/4_hear_bob/hear_bob.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  WelcomeScreen.routeName:(context) => const WelcomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  IHeardBobScreen.routeName: (context) => const IHeardBobScreen(),
  IHeardBobThanksScreen.routeName: (context) => const IHeardBobThanksScreen(),
  HearBobScreen.routeName: (context) => const HearBobScreen(),
  BobSightingsScreen.routeName: (context) => const BobSightingsScreen(),
};
