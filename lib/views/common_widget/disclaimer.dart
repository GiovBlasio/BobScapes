import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

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
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: (15)),
              decoration: const BoxDecoration(
                  color: kColor3,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: (10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: (30), right: (10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "Disclaimer",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp),
                          ),
                          IconButton(
                            splashRadius: 0.1,
                            icon: const Icon(
                              Icons.close,
                              size: (30),
                              color: kTextColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: (30), top: (30), bottom: (5), right: (40)),
                        child: Text(
                          "The exact location of your sightings will not be shared with the public.",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: (30), top: (20), bottom: (5), right: (40)),
                        child: Text(
                          "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp),
                        )),
                  ],
                ),
              )),
        ),
      ),
    ]);
  }
}
