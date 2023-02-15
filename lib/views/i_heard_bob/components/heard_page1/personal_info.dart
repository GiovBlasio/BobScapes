import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(15)),
          color: kColor2.withAlpha(45).withOpacity(0.5),
          child: Row(
            children: [
              const NameForm(),
              SizedBox(
                width: getProportionateScreenWidth(25),
              ),
              CustomDropDownMenu(items: widget.items)
            ],
          ),
        ));
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(15),
                bottom: getProportionateScreenHeight(8)),
            child: Text(
              "You are",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.w500,
                  color: kTextColor),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(0),
            ),
            child: Container(
              height: getProportionateScreenHeight(50),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              //color: Colors.red,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kTextColor.withOpacity(0.22), width: 0.3)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kTextColor.withOpacity(0.22), width: 0.3)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(12),
                          horizontal: getProportionateScreenWidth(12)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: kTextColor.withOpacity(0.22), width: 0.3)),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(13),
                      fontWeight: FontWeight.w500,
                    ),
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: kTextColor,
                    ),
                    items: widget.items.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/icon_customers.svg",
                              color: kTextColor,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Text(
                              item,
                              style: const TextStyle(color: kTextColor),
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
      ),
    );
  }

  void changeValue(String value) {
    context.read<HeardPage1State>().changeType(value);
  }

  void _initialization() {
    dropdownvalue = Provider.of<HeardPage1State>(context, listen: false).title;
  }
}

class NameForm extends StatefulWidget {
  const NameForm({
    Key? key,
  }) : super(key: key);

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final Set<String> errors = {};
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeName(String name) {
    context.read<HeardPage1State>().changeName(name);
  }

  void _initialization() {
    String name = Provider.of<HeardPage1State>(context, listen: false).name;
    if (name != '') controller = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: controller,
        keyboardType: TextInputType.name,
        onSaved: (newValue) {},
        onChanged: (value) {
          changeName(value);
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: kTextColor,
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.w500),
          hintStyle: TextStyle(
            color: kTextColor.withAlpha(177),
            fontSize: getProportionateScreenWidth(12),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kTextColor,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kTextColor,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: kTextColor,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red,
            ),
          ),
          labelText: "Your name (required)",
          hintText: "Shane Mahoney",
        ),
      ),
    ));
  }
}
