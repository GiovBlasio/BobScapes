import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: SvgPicture.asset(
            "assets/images/sfondo5.svg",
            fit: BoxFit.fill,
            width: SizeConfig.screenWidth,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(15)),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20)),
                        child: SvgPicture.asset(
                          "assets/images/logo-bobscapes.svg",
                          height: getProportionateScreenHeight(85),
                          width: getProportionateScreenWidth(40),
                        ),
                      ),
                      const Spacer(
                        flex: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(40)),
                        child: Text("Thank you",
                            style: TextStyle(
                                height: 1,
                                fontSize: getProportionateScreenWidth(40),
                                color: kTextColor,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(40)),
                        child: Text(
                          "for\nsubmitting \nyour \nsighting!",
                          style: TextStyle(
                            height: 1,
                            fontSize: getProportionateScreenWidth(40),
                            color: kTextColor,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          color: kTextColor,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          onPressed: () => showDialog(
                                useSafeArea: false,
                                barrierColor: Colors.white70,
                                context: context,
                                builder: (context) => Padding(
                                    padding: EdgeInsets.zero,
                                    child: _showDisclaimer(context)),
                              ),
                          icon: const Icon(Icons.info_outline)),
                      const Spacer(
                        flex: 2,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(kColor3),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          minimumSize: MaterialStateProperty.all(Size(
                              double.infinity,
                              getProportionateScreenHeight(65))),
                          backgroundColor: MaterialStateProperty.all(kColor3),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Back to home',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(20),
                              color: kTextColor),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  _showDisclaimer(BuildContext context) {
    return Stack(children: [
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Positioned(
              bottom: 400,
              left: 25,
              child: Image.asset(
                "assets/images/quail-reflected.png",
                height: 200,
              ),
            ),
            Positioned(
              height: 453,
              left: 25,
              right: 25,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                elevation: 10,
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(0)),
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(15)),
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
                                const Text(
                                  "Disclaimer",
                                  style: TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                IconButton(
                                  splashRadius: 0.1,
                                  icon: const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: kTextColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 30,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: Text(
                                "The exact location of your sightings will not be shared with the public.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        getProportionateScreenWidth(14.5)),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 20,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: const Text(
                                "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5),
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ]))
    ]);
  }
}
