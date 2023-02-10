import 'package:bobscapes/constants.dart';
import 'package:flutter/material.dart';

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
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: widget.groupValue != widget.value ? 2 : 8,
                color:
                    widget.groupValue == widget.value ? kColor1 : kTextColor)),
       
        margin: const EdgeInsets.all(2),
        child: Container(
          decoration:
              const BoxDecoration(color: kColor3, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
