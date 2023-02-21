import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';


//TODO
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    required this.isChecked,
  }) : super(key: key);

  final bool isChecked;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    _isSelected = widget.isChecked;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: kColor3,
            border: Border.all(color: kTextColor, width: 0.4),
            borderRadius: const BorderRadius.all(Radius.circular(3.5))),
        width: 35.h,
        height: 35.h,
        child: IconButton(
          splashRadius: 0.1,
          padding: EdgeInsets.zero,
          onPressed: () {
            // setState(() {
            //   widget.onChanged;
            // });
            // setState(() {
            //   decrementCounter(widget.id);
            // });
          },
          icon: _isSelected
              ? const Icon(
                  Icons.check,
                  color: kTextColor,
                )
              : Container(),
        ),
      ),
    );
  }
}
