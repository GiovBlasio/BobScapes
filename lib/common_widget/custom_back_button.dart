import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          Text(
            "BACK",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenWidth(12),
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
