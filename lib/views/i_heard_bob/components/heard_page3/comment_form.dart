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
              bottom: 8,
              top: 20),
          child: Text(
            "Leave a comment",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kTextColor),
          ),
        ),
        Flexible(
          child: TextFormField(
            enableInteractiveSelection: false,
            cursorColor: kTextColor,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: commentController,
            onSaved: (newValue) {},
            onChanged: (value) {
              changeComment(value);
            },
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withAlpha(200),
              constraints:
                  BoxConstraints(maxHeight: 100),
              labelStyle: TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              hintStyle: TextStyle(
                color: kTextColor.withOpacity(0.6),
                overflow: TextOverflow.visible,
                fontSize: 14,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                gapPadding: 20,
                borderSide:
                    BorderSide(color: kTextColor.withOpacity(0.22), width: 0.3),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: kTextColor.withOpacity(0.22), width: 0.3),
                borderRadius: BorderRadius.circular(5),
                gapPadding: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                gapPadding: 20,
                borderSide:
                    BorderSide(color: kTextColor.withOpacity(0.22), width: 0.3),
              ),
              hintText: "Write here...",
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 5,),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/icon-message.svg",
                    ),
                  ],
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 75, maxWidth: 28),
            ),
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
      ],
    );
  }
}
