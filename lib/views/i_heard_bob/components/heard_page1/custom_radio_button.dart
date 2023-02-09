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
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(8),
                bottom: getProportionateScreenHeight(8),
                right: getProportionateScreenWidth(10)),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                   // fontWeight: FontWeight.w500,
                    color: kTextColor),
                children: [
                  TextSpan(
                    text: widget.title,
                  ),
                  if (widget.id == 1)
                    const TextSpan(
                        text: ' (required)',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                        )),
                ],
              ),
            ),
          ),
          Row(
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
                                scale: getProportionateScreenHeight(1.5),
                                child: Radio(
                                    fillColor:
                                        const MaterialStatePropertyAll(kColor1),
                                    overlayColor:
                                        const MaterialStatePropertyAll(
                                            Colors.transparent),
                                    splashRadius: 0.1,
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
                                    fontWeight: FontWeight.w600,
                                    color: group == item
                                        ? kTextColor
                                        : kTextColor),
                              ),
                            ],
                          ),
                  )
                  .toList()),
        ],
      ),
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

class CustomRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final void Function(int) onChanged;
  const CustomRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.white : Colors.grey[200]),
        child: Icon(
          Icons.circle,
          size: 30,
          color: selected ? Colors.deepPurple : Colors.grey[200],
        ),
      ),
    );
  }
}
