import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          elevation: 10,
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(15)),
              //width: SizeConfig.screenWidth / 2,
              // height: 75,
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Disclaimer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenWidth(20.5)),
                          ),
                          IconButton(
                            splashRadius: 0.1,
                            icon: Icon(
                              Icons.close,
                              size: getProportionateScreenHeight(30),
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(30),
                            top: getProportionateScreenHeight(30),
                            bottom: getProportionateScreenHeight(5),
                            right: getProportionateScreenWidth(40)),
                        child: Text(
                          "The exact location of the sightings will not be shared with the public.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(14.5)),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(30),
                            top: getProportionateScreenHeight(20),
                            bottom: getProportionateScreenHeight(5),
                            right: getProportionateScreenWidth(40)),
                        child: Text(
                          "Contact information will only be shared if you selected \"Yes\" into the app.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(14.5)),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(30),
                            top: getProportionateScreenHeight(20),
                            bottom: getProportionateScreenHeight(30),
                            right: getProportionateScreenWidth(40)),
                        child: Text(
                          "Information will be used to inform management recommendations with conservation partners such as Quail Forever, USDA's NRCS and Univeristy of Georgia Martin Game Lab.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(14.5)),
                        )),
                  ],
                ),
              )),
        ),
      ),
    ]);
  }
}
