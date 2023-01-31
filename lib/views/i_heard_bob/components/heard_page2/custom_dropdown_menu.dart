import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      height: getProportionateScreenHeight(65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
               // left: getProportionateScreenWidth(10),
                bottom: getProportionateScreenHeight(8)),
            child: Text(
              "What did you see?",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              height: getProportionateScreenHeight(35),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              color: Colors.white.withAlpha(200),
              child: DropdownButton(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  underline: Container(),
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  items: widget.items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          item,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
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
        ],
      ),
    );
  }
}
