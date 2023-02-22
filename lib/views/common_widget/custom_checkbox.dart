import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

//TODO aggiungere Provider in modo che sia dinamico
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onPressed,
  }) : super(key: key);

  final bool isChecked;
  final Function() onPressed;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onPressed();
        });
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kColor3,
              border: Border.all(color: kTextColor, width: 0.4),
              borderRadius: const BorderRadius.all(
                Radius.circular(3.5),
              ),
            ),
            width: 35.h,
            height: 35.h,
            child: _isSelected
                ? const Icon(
                    Icons.check,
                    color: kTextColor,
                  )
                : Container(),
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            "unsure",
            style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Manrope',
                fontSize: 14.sp),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
