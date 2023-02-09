import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'routes.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HeardPage3State(),
    ),
    ChangeNotifierProvider(
      create: (context) => HeardPage2State(),
    ),
    ChangeNotifierProvider(
      create: (context) => HeardPage1State(),
    ),
  ], child: const MyApp()));
}

const TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
      color: Color(0xff8b8b8b), fontSize: 18, fontFamily: 'FjallaOne'),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Bob Scapes',
        theme: theme(context),
        initialRoute: SplashScreen.routeName,
        routes: routes,
        // localizationsDelegates: GlobalMaterialLocalizations.delegates,
        // supportedLocales: const [Locale('en'), Locale('it')],
      ),
    );
  }
}

ThemeData theme(BuildContext context) {
  return ThemeData(
    primarySwatch: MaterialColor(0xFF2C2C2C, {
      50: kPrimaryColor.withOpacity(0.10),
      100: kPrimaryColor.withOpacity(0.20),
      200: kPrimaryColor.withOpacity(0.30),
      300: kPrimaryColor.withOpacity(0.40),
      400: kPrimaryColor.withOpacity(0.50),
      500: kPrimaryColor.withOpacity(0.60),
      600: kPrimaryColor.withOpacity(0.70),
      700: kPrimaryColor.withOpacity(0.80),
      800: kPrimaryColor.withOpacity(0.90),
      900: kPrimaryColor
    }),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xfff0f0f0),
    appBarTheme: appBarTheme(),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          fontFamily: 'Manrope',
        ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

// InputDecorationTheme inputDecorationTheme() {
//   UnderlineInputBorder underlineInputBorder = underlineBorder(
//     color: kPrimaryColor,
//     width: 1.5,
//   );
//   UnderlineInputBorder errorInputBorder = underlineBorder(
//     color: kSecondaryColor,
//     width: 1.5,
//   );
//   UnderlineInputBorder focusedErrorBorder = underlineBorder(
//     color: kSecondaryColor,
//     width: 1.5,
//   );
//   return InputDecorationTheme(
//     labelStyle: const TextStyle(
//       color: kPrimaryColor,
//     ),
//     hintStyle: TextStyle(
//       color: kPrimaryColor.withAlpha(177),
//       fontSize: 13,
//     ),
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     contentPadding: const EdgeInsets.only(
//       left: 0,
//       top: 0,
//       bottom: 0,
//     ),
//     enabledBorder: underlineInputBorder,
//     focusedBorder: underlineInputBorder,
//     border: underlineInputBorder,
//     errorBorder: errorInputBorder,
//     focusedErrorBorder: focusedErrorBorder,
//   );
// }

// OutlineInputBorder outlineBorder(
//     {required Color color, required double width}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(28),
//     borderSide: BorderSide(
//       width: width,
//       color: color,
//     ),
//     gapPadding: 10,
//   );
// }

// UnderlineInputBorder underlineBorder(
//     {required Color color, required double width}) {
//   return UnderlineInputBorder(
//     borderSide: BorderSide(
//       width: width,
//       color: color,
//     ),
//   );
// }

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    color: const Color(0xfff5f5f5),
    elevation: 3,
    systemOverlayStyle: const SystemUiOverlayStyle(
        //  systemNavigationBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.amber,

        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent),
    iconTheme: const IconThemeData(color: kPrimaryColor),
    titleTextStyle: textTheme.titleLarge,
  );
}
