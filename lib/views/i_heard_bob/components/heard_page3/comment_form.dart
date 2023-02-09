import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({
    super.key,
  });

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeComment(String comment) {
    context.read<HeardPage3State>().changeComment(comment);
  }

  void _initialization() {
    String comment =
        Provider.of<HeardPage3State>(context, listen: false).comment;

    if (comment != '') commentController = TextEditingController(text: comment);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              // left: getProportionateScreenWidth(15),
              bottom: getProportionateScreenHeight(8),
              top: getProportionateScreenHeight(20)),
          child: Text(
            "Leave a comment",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.w500,
                color: kTextColor),
          ),
        ),
        Flexible(
          child: TextFormField(
            enableInteractiveSelection: false,
            cursorColor: kPrimaryColor,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: commentController,
            onSaved: (newValue) {
              //  location = newValue ?? "";
            },
            onChanged: (value) {
              //changeComment(value);
              // commentController.text = value;
            },
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(200),
              constraints:
                  BoxConstraints(maxHeight: getProportionateScreenHeight(100)),
              labelStyle: TextStyle(
                  color: kPrimaryColor,
                  // fontFamily: "Heebo",
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w500),
              hintStyle: TextStyle(
                overflow: TextOverflow.visible,
                // color: Colors.black.withAlpha(177),
                fontSize: getProportionateScreenWidth(13),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.only(
                  left: getProportionateScreenWidth(10),
                  right: getProportionateScreenWidth(10),
                  top: getProportionateScreenHeight(5)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                gapPadding: 20,
                borderSide: const BorderSide(color: kTextColor, width: 0.3),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: kTextColor, width: 0.3),
                borderRadius: BorderRadius.circular(10),
                gapPadding: 20,
              ),
              hintText: "Write here...",
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(5)),
                child: SvgPicture.asset(
                  "assets/icons/icon-message.svg",
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: getProportionateScreenHeight(28),
                  maxWidth: getProportionateScreenWidth(28)),
            ),
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
      ],
    );
  }
}
