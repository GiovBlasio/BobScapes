import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    required this.title,
    required this.color,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final Color color;
  final String icon;
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
          child: Row(
            children: [
              const Spacer(
                flex: 5,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 3,),
              SvgPicture.asset(
                icon,
                height: getProportionateScreenHeight(30),
                color: Colors.white,
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
