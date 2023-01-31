import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    required this.title,
    required this.color,
    Key? key,
  }) : super(key: key);

  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      elevation: 10,
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(18), vertical: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          width: double.infinity,
          height: getProportionateScreenHeight(50),
          color: color,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
