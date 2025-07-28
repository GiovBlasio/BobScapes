import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page3_state.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
            ),
            child: Text(
              "Leave a comment",
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
                color: kTextLightColor,
              ),
            ),
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
              enableInteractiveSelection: false,
              cursorColor: kTextColor,
              expands: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: commentController,
              onChanged: (value) {
                changeComment(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withAlpha(200),
                constraints: BoxConstraints(maxHeight: 100.h),
                labelStyle: TextStyle(
                    color: kTextColor,
                    fontSize: 15.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500),
                hintStyle: TextStyle(
                  color: kTextColor,
                  fontSize: 12.sp,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.only(top: 5.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 20,
                  borderSide: BorderSide(
                    color: kTextColor.withOpacity(0.22),
                    width: .5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 4,
                  borderSide: BorderSide(
                    color: kTextColor.withOpacity(0.22),
                    width: .5,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: kTextColor.withOpacity(0.22), width: 0.3),
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 4),
                hintText: "Write here...",
                prefixIcon: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 11.h
                  ),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 11.h,
                      // ),
                      SvgPicture.asset(
                        "assets/icons/icon-message.svg",
                      ),
                    ],
                  ),
                ),
                // prefixIconConstraints:
                //     BoxConstraints(maxHeight: 75.h, maxWidth: 55.w),
              ),
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }
}
