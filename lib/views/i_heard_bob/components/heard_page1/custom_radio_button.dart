import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({
    required this.items,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  final Set<String> items;
  final String title;
  final int id;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  late String group = groupValue(widget.id);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(8),
              bottom: getProportionateScreenHeight(8),
              // left: getProportionateScreenWidth(15),
              right: getProportionateScreenWidth(10)),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ),
        Row(
            //TODO
             crossAxisAlignment: CrossAxisAlignment.baseline,
             textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items
                .map(
                  (item) => (item == '1' || item == '2')
                      ? SizedBox(
                          height: getProportionateScreenHeight(45),
                          width: getProportionateScreenWidth(65),
                        )
                      : Column(
                          children: [
                            Transform.scale(
                              //TODO
                              scale: getProportionateScreenHeight(1.3),
                              child: Radio(
                                  // focusColor: Colors.amber,
                                  fillColor:
                                      const MaterialStatePropertyAll(kColor1),
                                  overlayColor:
                                      const MaterialStatePropertyAll(
                                          Colors.transparent),
                                  activeColor: kColor1,
                                  value: item,
                                  groupValue: group,
                                  onChanged: (value) {
                                    changeValue(widget.id, value!);
                                    setState(() {
                                      group = value;
                                    });
                                  }),
                            ),
                            Text(
                              item,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  fontWeight: FontWeight.w700,
                                  color:
                                      group == item ? kPrimaryColor : Colors.white),
                            ),
                          ],
                        ),
                )
                .toList()),
      ],
    );
  }

  String groupValue(int id) {
    switch (id) {
      case 1:
        return Provider.of<HeardPage1State>(context, listen: false)
            .releasedIntoLocation;
      case 2:
        return Provider.of<HeardPage1State>(context, listen: false)
            .physicallySee;
      default:
        return 'Yes';
    }
  }

  void changeValue(int id, String value) {
    switch (id) {
      case 1:
        context.read<HeardPage1State>().changeReleasedLocation(value);
        break;
      case 2:
        context.read<HeardPage1State>().changePhysicallySee(value);
        break;
    }
  }
}
