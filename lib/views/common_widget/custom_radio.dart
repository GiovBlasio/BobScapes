import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({
    Key? key,
    required this.groupValue,
    required this.value,
    this.onChanged,
  }) : super(key: key);
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.groupValue != widget.value;
        if (selected) {
          widget.onChanged!(widget.value);
        }
      },
      child: Container(
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: widget.groupValue == widget.value ? kColor1 : kColor3,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.groupValue == widget.value ? kColor1 : kTextColor,
          ),
        ),
        child: Center(
          child: Container(
            height: 12.h,
            width: 12.w,
            decoration: const BoxDecoration(
              color: kColor3,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
