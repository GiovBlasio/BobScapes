import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page2_state.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  late String dropdownvalue;

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeValue(String value) {
    context.read<HeardPage2State>().changeWhatSee(value);
  }

  void _initialization() {
    dropdownvalue =
        Provider.of<HeardPage2State>(context, listen: false).whatSee;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            bottom: 8.h,
          ),
          child: Text(
            "What did you see?",
            style: TextStyle(
              color: kTextLightColor,
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(0),
          ),
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(0)),
              color: Colors.white,
              border: Border.all(color: kColor3, width: 0.3),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                  dropdownColor: kColor3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22),
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22),
                        width: 0.3,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22),
                        width: 0.3,
                      ),
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 16.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: kTextColor,
                    size: 28,
                  ),
                  items: widget.items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icons/icon-bird.svg"),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            item,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w700,
                                color: kTextColor),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    changeValue(newValue!);
                    setState(() {
                      dropdownvalue = newValue;
                    });
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
