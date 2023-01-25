import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/birds_counter.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
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
    return Container(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(10),
        right: getProportionateScreenWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              //color: Colors.amber,
              constraints: BoxConstraints(
                  maxWidth: widget.id != 5
                      ? getProportionateScreenWidth(200)
                      : getProportionateScreenWidth(125)),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w500),
              )),
          if (widget.id == 5)
            Tooltip(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 25, right: 25),
              margin: const EdgeInsets.only(left: 90, right: 50),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              showDuration: const Duration(seconds: 25),
              triggerMode: TooltipTriggerMode.tap,
              verticalOffset: getProportionateScreenHeight(-165),
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.w500),
              message:
                  'During the summer months, female will join up, resulting in mixed age groups of young.\n\nYour answer should reflect how many age groups you see.',
              child: const Icon(
                Icons.info_outline,
                color: kPrimaryColor,
              ),
            ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(3.5))),
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
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: getProportionateScreenHeight(15),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(55),
                child: TextFormField(
                  toolbarOptions: const ToolbarOptions(),
                  enableInteractiveSelection: false,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: controller,
                  readOnly: true,
                  decoration: const InputDecoration.collapsed(hintText: ""),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(3.5))),
                //color: Colors.black,
                width: getProportionateScreenWidth(20),
                height: getProportionateScreenHeight(20),
                child: IconButton(
                  splashRadius: 0.1,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    incrementCounter(widget.id);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void decrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<BirdsCounter>().decrementTotalCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<BirdsCounter>().decrementMaleCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<BirdsCounter>().decrementFemaleCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<BirdsCounter>().decrementYoungCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).youngCounter)
                .toString();
        break;

      case 5:
        context.read<BirdsCounter>().decrementBroodsCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  void incrementCounter(int id) {
    switch (id) {
      case 1:
        context.read<BirdsCounter>().incrementTotalCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).totalCounter)
                .toString();
        break;
      case 2:
        context.read<BirdsCounter>().incrementMaleCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).maleCounter)
                .toString();
        break;
      case 3:
        context.read<BirdsCounter>().incrementFemaleCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).femaleCounter)
                .toString();
        break;
      case 4:
        context.read<BirdsCounter>().incrementYoungCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).youngCounter)
                .toString();
        break;
      case 5:
        context.read<BirdsCounter>().incrementBroodsCounter();
        controller.text =
            (Provider.of<BirdsCounter>(context, listen: false).broodsCounter)
                .toString();
        break;
      default:
    }
  }

  String initialValue(int id) {
    switch (id) {
      case 1:
        return (Provider.of<BirdsCounter>(context, listen: false).totalCounter)
            .toString();
      case 2:
        return (Provider.of<BirdsCounter>(context, listen: false).maleCounter)
            .toString();
      case 3:
        return (Provider.of<BirdsCounter>(context, listen: false).femaleCounter)
            .toString();
      case 4:
        return (Provider.of<BirdsCounter>(context, listen: false).youngCounter)
            .toString();
      case 5:
        return (Provider.of<BirdsCounter>(context, listen: false).broodsCounter)
            .toString();
      default:
        return '0';
    }
  }
}
