import 'package:bobscapes/common_widget/disclaimer.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: getProportionateScreenWidth(35),
          right: 0,
          top: getProportionateScreenHeight(75),
          child: Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: getProportionateScreenHeight(75),
                color: Colors.white,
              ),
              SizedBox(
                width: getProportionateScreenWidth(15),
              ),
              Text(
                "Bobscapes",
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(33),
                    color: const Color(0xbbffffff),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(32),
          right: getProportionateScreenWidth(32),
          top: getProportionateScreenHeight(225),
          child: Text(
            "THANK YOU\nFOR \nSUBMITTING \nYOUR \nSIGHTING!",
            style: TextStyle(
                height: 1,
                fontSize: getProportionateScreenWidth(45),
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ),
        Positioned(
          left: getProportionateScreenWidth(15),
          right: 0,
          bottom: getProportionateScreenHeight(85),
          child: IconButton(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              onPressed: () => showDialog(
                  barrierColor: Colors.white70,
                  context: context,
                  builder: (context) => const Disclaimer()),
              icon: const Icon(Icons.info_outline)),
        ),
        Positioned(
          left: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(15),
          bottom: getProportionateScreenHeight(15),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              minimumSize:
                  Size(double.infinity, getProportionateScreenHeight(65)),
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Back to home',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(20),
                  color: kPrimaryColor),
            ),
          ),
        )
      ],
    );
  }
}
