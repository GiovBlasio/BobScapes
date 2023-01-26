import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'heard_page3/radio_button.dart';

class HeardPage3 extends StatefulWidget {
  const HeardPage3({super.key});

  @override
  State<HeardPage3> createState() => _HeardPage3State();
}

class _HeardPage3State extends State<HeardPage3> {
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late bool isEnabled = true;

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeComment(String comment) {
    context.read<HeardPage3State>().changeComment(comment);
  }

  void changeEmail(String email) {
    context.read<HeardPage3State>().changeEmail(email);
  }

  void _initialization() {
    isEnabled = Provider.of<HeardPage3State>(context, listen: false).isEnable;
    String comment =
        Provider.of<HeardPage3State>(context, listen: false).comment;

    if (comment != '') commentController = TextEditingController(text: comment);

    String email = Provider.of<HeardPage3State>(context, listen: false).email;

    if (email != '' && isEnabled) {
      emailController = TextEditingController(text: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15), vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Register your sighting".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(14)),
                ),
                IconButton(
                  splashRadius: 0.1,
                  icon: Icon(
                    Icons.close,
                    size: getProportionateScreenHeight(28),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRadioButton(
                      items: {'Yes', 'No', '1', '2'},
                      title: "Did you want more information about Bobwhite?",
                      id: 1),
                  const CustomRadioButton(
                      items: {'Yes', 'No', 'I\'m alredy registered', '1'},
                      title: "Want to learn more about Bobwhite cost sharing?",
                      id: 2),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(15)),
                      child: Form(
                          child: TextFormField(
                        enabled: context.watch<HeardPage3State>().isEnable,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        onTap: (() {
                          //  FocusScope.of(context).requestFocus(FocusNode());
                        }),
                        onSaved: (newValue) {
                          //  location = newValue ?? "";
                        },
                        onChanged: (value) {
                          changeEmail(value);
                          // emailController.text = value;
                        },
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          enabled: context.watch<HeardPage3State>().isEnable,
                          labelStyle: TextStyle(
                              color: context.watch<HeardPage3State>().isEnable
                                  ? kPrimaryColor
                                  : null,
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(
                            color: context.watch<HeardPage3State>().isEnable
                                ? kPrimaryColor
                                : null,
                            fontSize: getProportionateScreenWidth(14),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.only(
                            left: 0,
                            top: 0,
                            bottom: 0,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
                            ),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: kPrimaryColor,
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
                          // suffixIcon: const Icon(
                          //   Icons.email,
                          //   color: kPrimaryColor,
                          // ),
                          labelText: "Your email",
                          hintText: "hello@aol.com",
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(15),
                        bottom: getProportionateScreenHeight(8),
                        top: getProportionateScreenHeight(20)),
                    child: Text(
                      "Leave a comment",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: commentController,
                      onSaved: (newValue) {
                        //  location = newValue ?? "";
                      },
                      onChanged: (value) {
                        changeComment(value);
                        // commentController.text = value;
                      },
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xbbf2f2f2),
                        constraints: BoxConstraints(
                            maxHeight: getProportionateScreenHeight(100)),
                        labelStyle: TextStyle(
                            color: kPrimaryColor,
                            // fontFamily: "Heebo",
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                          overflow: TextOverflow.visible,
                          color: kPrimaryColor.withAlpha(177),
                          fontFamily: "Heebo",
                          fontSize: getProportionateScreenWidth(15),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(20)
                            // top: 20,
                            //bottom: 20,
                            ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 20,
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 20,
                        ),
                        hintText: "Write here...",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  // DefaultButton(
                  //     text: "Invia",
                  //     press: () => Navigator.popAndPushNamed(
                  //         context, IHeardBobThanksScreen.routeName))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
