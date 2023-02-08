import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page3_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({
    super.key,
  });

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  TextEditingController emailController = TextEditingController();

  late bool isEnabled = true;

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeEmail(String email) {
    context.read<HeardPage3State>().changeEmail(email);
  }

  void _initialization() {
    isEnabled = Provider.of<HeardPage3State>(context, listen: false).isEnable;

    String email = Provider.of<HeardPage3State>(context, listen: false).email;

    if (email != '' && isEnabled) {
      emailController = TextEditingController(text: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
                color: context.watch<HeardPage3State>().isEnable
                    ? kTextColor
                    : kTextColor.withOpacity(0.6),
                fontWeight: FontWeight.w400),
            children: [
              const TextSpan(text: 'Your email '),
              if (context.watch<HeardPage3State>().isEnable)
                const TextSpan(
                    text: '(required)',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: kTextColor)),
            ],
          ),
        ),
        Flexible(
          child: Form(
              child: TextFormField(
            style:
                const TextStyle(color: kTextColor, fontWeight: FontWeight.w500),
            enableInteractiveSelection: false,
            cursorColor: kPrimaryColor,
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
                      ? kTextColor
                      : null,
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w500),
              hintStyle: TextStyle(
                  color: context.watch<HeardPage3State>().isEnable
                      ? kTextColor.withOpacity(0.6)
                      : null,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w300),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.all(
                getProportionateScreenWidth(8),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: kTextColor,
                ),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  // color: Colors.white,
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
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(5)),
                child: SvgPicture.asset(
                  "assets/icons/icon-mail.svg",
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: getProportionateScreenHeight(28),
                  maxWidth: getProportionateScreenWidth(28)),
              hintText: "hello@aol.com",
            ),
          )),
        ),
      ],
    );
  }
}
