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
              top: Radius.circular(16),
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
                  color: kColor3,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(30),
                          right: getProportionateScreenWidth(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "Disclaimer",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenWidth(20.5)),
                          ),
                          IconButton(
                            splashRadius: 0.1,
                            icon: Icon(
                              Icons.close,
                              size: getProportionateScreenHeight(30),
                              color: kPrimaryColor,
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
                          "The exact location of your sightings will not be shared with the public.",
                          style: TextStyle(
                              color: kPrimaryColor,
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
                          "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(14.5)),
                        )), // Padding(
                    //     padding: EdgeInsets.only(
                    //         left: getProportionateScreenWidth(30),
                    //         top: getProportionateScreenHeight(20),
                    //         bottom: getProportionateScreenHeight(30),
                    //         right: getProportionateScreenWidth(40)),
                    //     child: Text(
                    //       "Information will be used to inform management recommendations with conservation partners such as Quail Forever, USDA's NRCS and Univeristy of Georgia Martin Game Lab.",
                    //       style: TextStyle(
                    //           color: kPrimaryColor,
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: getProportionateScreenWidth(14.5)),
                    //     )),
                  ],
                ),
              )),
        ),
      ),
    ]);
  }
}
