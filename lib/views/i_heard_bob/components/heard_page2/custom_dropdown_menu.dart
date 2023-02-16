import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 0),
                  child: Text(
                    "What did you see?",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.w500,
                        color: kTextColor),
                  ),
                ),
               // const Spacer(),
                // SvgPicture.asset(
                //   "assets/icons/mini-quail.svg",
                //   height: getProportionateScreenHeight(90),
                // )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(0),
            )
          ],
        ),
        
        Positioned(
          top: 25,
          right: 0,
          left: 0,
         // bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
            child: Container(
              height: 45,
              //   width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5)),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(0)),

                color: Colors.white,
                // focusedBorder: const OutlineInputBorder(
                //      borderSide:
                //          BorderSide(color: kTextColor, width: 0.3)),
                //  contentPadding: EdgeInsets.symmetric(
                //      vertical: getProportionateScreenHeight(12),
                //      horizontal: getProportionateScreenWidth(12)),
                border: Border.all(color: kColor3, width: 0.3),
              ),
              //  style: TextStyle(
              //    color: kTextColor,
              //    fontSize: getProportionateScreenWidth(13),
              //    fontWeight: FontWeight.w500,
              //  ),
              // child: DropdownButtonHideUnderline(
              //   child: DropdownButtonFormField(
              //       decoration: InputDecoration(
              //         focusedBorder: const OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: kTextColor, width: 0.3)),
              //         contentPadding: EdgeInsets.symmetric(
              //             vertical: getProportionateScreenHeight(12),
              //             horizontal: getProportionateScreenWidth(12)),
              //         border: const OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: kTextColor, width: 0.3)),
              //       ),
              //       borderRadius: const BorderRadius.all(Radius.circular(0)),
              //       style: TextStyle(
              //         color: kTextColor,
              //         fontSize: getProportionateScreenWidth(13),
              //         fontWeight: FontWeight.w500,
              //       ),
              //       isExpanded: true,
              //       value: dropdownvalue,
              //       icon: Icon(
              //         Icons.keyboard_arrow_down,
              //         color: kTextColor,
              //         size: getProportionateScreenWidth(28),
              //       ),
              //       //iconSize: getProportionateScreenHeight(24),
              //       items: widget.items.map((String item) {
              //         return DropdownMenuItem(
              //           value: item,
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 5),
              //             child: Row(
              //               children: [
              //                 SvgPicture.asset("assets/icons/icon-bird.svg"),
              //                 SizedBox(
              //                   width: getProportionateScreenWidth(5),
              //                 ),
              //                 Text(
              //                   item,
              //                   style: TextStyle(
              //                       fontSize: getProportionateScreenWidth(14),
              //                       fontWeight: FontWeight.w500,
              //                       color: kTextColor),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         );
              //       }).toList(),
              //       onChanged: (String? newValue) {
              //         changeValue(newValue!);
              //         setState(() {
              //           dropdownvalue = newValue;
              //         });
              //       }),
              // ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/icon-bird.svg"),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  Text(
                    widget.items[0],
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.w500,
                    ),
                    // style: TextStyle(

                    //     fontSize: getProportionateScreenWidth(14),
                    //     fontWeight: FontWeight.w500,
                    //     color: kTextColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
