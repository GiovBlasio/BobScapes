import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page2_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NumericalQuestion extends StatefulWidget {
  const NumericalQuestion({
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  final String title;
  final int id;

  @override
  State<NumericalQuestion> createState() => _NumericalQuestionState();
}

class _NumericalQuestionState extends State<NumericalQuestion> {
  late TextEditingController controller =
      TextEditingController(text: initialValue(widget.id));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            constraints: BoxConstraints(
                maxWidth: widget.id != 5
                    ? 200
                    : 135),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kTextColor),
            )),
        if (widget.id == 5)
          Container(
            padding: const EdgeInsets.only(top: 4, left: 5),
            child: Tooltip(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenWidth(20)),
              margin: EdgeInsets.only(
                  left: getProportionateScreenWidth(90),
                  right: getProportionateScreenWidth(50)),
              decoration: const BoxDecoration(
                color: kColor2,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              showDuration: const Duration(seconds: 25),
              triggerMode: TooltipTriggerMode.tap,
            //  verticalOffset: getProportionateScreenHeight(-165),
              textStyle: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              message:
                  'During the summer months, female will join up, resulting in mixed age groups of young.\n\nYour answer should reflect how many age groups you see.',
              child: SvgPicture.asset(
                "assets/icons/icon-info.svg",
                height: 18,
              ),
            ),
          ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: kColor3,
                  border: Border.all(color: kTextColor, width: 0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(3.5))),
              width: getProportionateScreenWidth(20),
              height: getProportionateScreenHeight(20),
              child: IconButton(
                  splashRadius: 0.1,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      decrementCounter(widget.id);
                    });
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/icon-minus.svg",
                    width: getProportionateScreenWidth(13),
                  )),
            ),
            SizedBox(
              width: getProportionateScreenWidth(55),
              child: TextFormField(
                contextMenuBuilder: (context, editableTextState) {
                  return Container();
                },
                style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w500,
                ),
                enableInteractiveSelection: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: controller,
                readOnly: true,
                decoration: const InputDecoration.collapsed(hintText: ""),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: kColor3,
                  border: Border.all(color: kTextColor, width: 0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(3.5))),
              width: getProportionateScreenWidth(20),
              height: getProportionateScreenHeight(20),
              child: IconButton(
                  iconSize: getProportionateScreenHeight(15),
                  splashRadius: 0.1,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    incrementCounter(widget.id);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/icon-plus.svg",
                    width: getProportionateScreenWidth(13),
                  )),
            ),
          ],
        )
      ],
    );
  }

  void decrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<HeardPage2State>().decrementTotalCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<HeardPage2State>().decrementMaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<HeardPage2State>().decrementFemaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<HeardPage2State>().decrementYoungCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).youngCounter)
                .toString();
        break;

      case 5:
        context.read<HeardPage2State>().decrementBroodsCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  void incrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<HeardPage2State>().incrementTotalCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<HeardPage2State>().incrementMaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<HeardPage2State>().incrementFemaleCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<HeardPage2State>().incrementYoungCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).youngCounter)
                .toString();
        break;
      case 5:
        context.read<HeardPage2State>().incrementBroodsCounter();
        controller.text =
            (Provider.of<HeardPage2State>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  String initialValue(int id) {
    switch (id) {
      case 1:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .totalCounter)
            .toString();
      case 2:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .maleCounter)
            .toString();
      case 3:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .femaleCounter)
            .toString();
      case 4:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .youngCounter)
            .toString();
      case 5:
        return (Provider.of<HeardPage2State>(context, listen: false)
                .broodsCounter)
            .toString();
      default:
        return '0';
    }
  }
}
