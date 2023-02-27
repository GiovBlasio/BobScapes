import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'provider/heard_page/heard_page1_state.dart';
import 'provider/heard_page/heard_page2_state.dart';
import 'provider/heard_page/heard_page3_state.dart';
import 'provider/heard_page/home_state.dart';
import 'routes.dart';
import 'views/1_splash/splash_screen.dart';
// import 'package:sizer/sizer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HeardPage3State(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeState(),
        ),
        ChangeNotifierProvider(
          create: (context) => HeardPage2State(),
        ),
        ChangeNotifierProvider(
          create: (context) => HeardPage1State(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'Bobscapes',
          theme: ThemeData(
            fontFamily: 'Manrope',
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
            primaryColor: kTextColor,
            scaffoldBackgroundColor: const Color(0xfff0f0f0),
            appBarTheme: appBarTheme(),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: kTextColor,
                  fontFamily: 'Manrope',
                ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        );
      },
      designSize: const Size(390, 844),
    );
  }
}

AppBarTheme appBarTheme() {
  TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
        color: const Color(0xff8b8b8b),
        fontSize: 18.sp,
        fontFamily: 'FjallaOne'),
  );

  return AppBarTheme(
    centerTitle: true,
    color: const Color(0xfff5f5f5),
    elevation: 3,
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
    iconTheme: const IconThemeData(color: kTextColor),
    titleTextStyle: textTheme.titleLarge,
  );
}
