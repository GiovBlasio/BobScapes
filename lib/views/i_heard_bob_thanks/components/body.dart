import 'package:bobscapes/views/common_widget/disclaimer.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            "assets/images/Welcome Background.svg",
            fit: BoxFit.cover,
            // height: SizeConfig.screenHeight,
            width: double.infinity,
          ),
        ),
        // Container(
        //   height: SizeConfig.screenHeight,
        //   width: SizeConfig.screenWidth,
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       kColor2.withOpacity(0.6),
        //       kColor1.withOpacity(0.6),
        //       kColor1,
        //     ],
        //   )),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              const Spacer(),
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          "assets/images/logo-bobscapes.svg",
                          height: getProportionateScreenHeight(85),
                          width: getProportionateScreenWidth(40),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(25)),
                        child: Text("Thank you",
                            style: TextStyle(
                                height: 1,
                                fontSize: getProportionateScreenWidth(40),
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(25)),
                        child: Text(
                          "for\nsubmitting \nyour \nsighting!",
                          style: TextStyle(
                            height: 1,
                            fontSize: getProportionateScreenWidth(40),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          onPressed: () => showDialog(
                              useSafeArea: false,
                              barrierColor: Colors.white70,
                              context: context,
                              builder: (context) => const Disclaimer()),
                          icon: const Icon(Icons.info_outline)),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(kColor2),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          minimumSize: MaterialStateProperty.all(Size(
                              double.infinity,
                              getProportionateScreenHeight(65))),
                          backgroundColor: MaterialStateProperty.all(kColor2),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Back to home',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(20),
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        // Positioned(
        //   left: getProportionateScreenWidth(35),
        //   right: 0,
        //   top: getProportionateScreenHeight(75),
        //   child: Row(
        //     children: [
        //       Icon(
        //         Icons.remove_red_eye_outlined,
        //         size: getProportionateScreenHeight(75),
        //         color: Colors.white,
        //       ),
        //       SizedBox(
        //         width: getProportionateScreenWidth(15),
        //       ),
        //       Text(
        //         "Bobscapes",
        //         style: TextStyle(
        //             fontSize: getProportionateScreenHeight(33),
        //             color: const Color(0xbbffffff),
        //             fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        // ),
        //  Positioned(
        //   left: getProportionateScreenWidth(32),
        //   right: getProportionateScreenWidth(32),
        //   top: getProportionateScreenHeight(225),
        //   child: Text(
        //     "THANK YOU\nFOR \nSUBMITTING \nYOUR \nSIGHTING!",
        //     style: TextStyle(
        //         height: 1,
        //         fontSize: getProportionateScreenWidth(45),
        //         color: Colors.white,
        //         fontStyle: FontStyle.italic),
        //   ),
        // ),
        // Positioned(
        //   left: getProportionateScreenWidth(15),
        //   right: 0,
        //   bottom: getProportionateScreenHeight(85),
        //   child: IconButton(
        //       color: Colors.white,
        //       alignment: Alignment.centerLeft,
        //       padding: EdgeInsets.zero,
        //       onPressed: () => showDialog(
        //           barrierColor: Colors.white70,
        //           context: context,
        //           builder: (context) => const Disclaimer()),
        //       icon: const Icon(Icons.info_outline)),
        // ),
        //   Positioned(
        //     left: getProportionateScreenWidth(15),
        //     right: getProportionateScreenWidth(15),
        //     bottom: getProportionateScreenHeight(15),
        //     child: TextButton(
        //       style: TextButton.styleFrom(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(24)),
        //         minimumSize:
        //             Size(double.infinity, getProportionateScreenHeight(65)),
        //         backgroundColor: Colors.white,
        //         padding: const EdgeInsets.all(0),
        //       ),
        //       onPressed: () => Navigator.pop(context),
        //       child: Text(
        //         'Back to home',
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: getProportionateScreenWidth(20),
        //             color: kPrimaryColor),
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
