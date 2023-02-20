import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';

class BottomSheetCards extends StatefulWidget {
  const BottomSheetCards({
    super.key,
    required this.state,
    required this.item,
    required this.sightings,
  });

  final List<String> state;
  final int item;
  final List<int> sightings;

  @override
  State<BottomSheetCards> createState() => _BottomSheetCardsState();
}

class _BottomSheetCardsState extends State<BottomSheetCards> {
  late final PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.item;
    pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.42,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 239.h,
      width: ScreenUtil().screenWidth,
      child: Column(
        //  mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: 8.h,
            ),
            height: 4.h,
            width: 100.w,
          ),
          LimitedBox(
            maxHeight: 219.h,
            maxWidth: 153.w,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                currentIndex = index % widget.state.length;
                setState(() {});
              },
              itemBuilder: (_, index) {
                return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: UnconstrainedBox(
                      child: Column(
                        children: [
                          AnimatedContainer(
                            //  color: Colors.red,
                            duration: const Duration(milliseconds: 750),
                            height: currentIndex == index % widget.state.length
                                ? 0
                                : 60.h,
                          ),
                          AnimatedContainer(
                            // color: Colors.red,
                            duration: const Duration(milliseconds: 750),
                            height: currentIndex == index % widget.state.length
                                ? 219.h
                                : 159.h,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: 219.h,
                                  maxWidth: 153.w,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 0.h),
                                // margin: EdgeInsets.only(
                                //     left: 20.w,
                                //     right: 13.w,
                                //     top: 17.h,
                                //     bottom: 3.h),
                                decoration: BoxDecoration(
                                    color: currentIndex ==
                                            index % widget.state.length
                                        ? kColor3
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    height: 219.h,
                                    width: 153.w,
                                    child: Stack(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Positioned(
                                          top: 17.h,
                                          left: 20.w,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 153.w,
                                            child: Text(
                                              widget.state[
                                                  index % widget.state.length],
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w700,
                                                color: kTextColor,
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 42.h,
                                          left: 20.w,
                                          right: 0,
                                          bottom: 0,
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 750),
                                            height: currentIndex == index
                                                ? 60.h
                                                : 5.h,
                                          ),
                                        ),
                                        Positioned(
                                          top: 103.h,
                                          left: 20.w,
                                          right: 0,
                                          bottom: 0,
                                          child: Text(
                                            "Bob has",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: kTextColor,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 750),
                                          top: 119.h,
                                          left: 20.w,
                                          right: 0,
                                          bottom: 0,
                                          child: Text(
                                            "been heard",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: kTextColor,
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        // Text(
                                        //   "Bob has\nbeen heard",
                                        //   style: TextStyle(
                                        //       fontSize: 14.sp,
                                        //       color: kTextColor,
                                        //       fontFamily: 'Manrope',
                                        //       fontWeight: FontWeight.w500),
                                        // ),
                                        Positioned(
                                          left: 20.w,
                                          top: 140.h,
                                          right: 0,
                                          bottom: 0,
                                          child: Text(
                                            "${widget.sightings[index % widget.state.length]}",
                                            style: TextStyle(
                                              fontSize: 40.sp,
                                              color: kTextColor,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          left: 95.w,
                                          top: 164.h,
                                          right: 13.w,
                                          bottom: 0,
                                          child: Text(
                                            "times",
                                            style: TextStyle(
                                                fontFamily: 'Manrope',
                                                fontWeight: FontWeight.w700,
                                                color: kTextColor,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                        // // Row(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.baseline,
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   textBaseline: TextBaseline.alphabetic,
                                        //   children: [
                                        //     RichText(
                                        //       text: TextSpan(
                                        //         style: TextStyle(
                                        //           fontSize: 42.sp,
                                        //           color: kTextColor,
                                        //           fontFamily: 'Manrope',
                                        //           fontWeight: FontWeight.w300,
                                        //         ),
                                        //         children: [
                                        //           TextSpan(
                                        //             text:
                                        //                 "${widget.sightings[index % widget.state.length]}",
                                        //           ),
                                        //           if (widget.sightings[index %
                                        //                       widget.state.length]
                                        //                   .toString()
                                        //                   .length ==
                                        //               1)
                                        //             TextSpan(
                                        //                 text: '1',
                                        //                 style: TextStyle(
                                        //                   fontSize: 42.sp,
                                        //                   color: kColor3,
                                        //                   fontFamily: 'Manrope',
                                        //                   fontWeight:
                                        //                       FontWeight.w300,
                                        //                 )),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 23.w,
                                        //     ),
                                        //     Text(
                                        //       "times",
                                        //       style: TextStyle(
                                        //           fontFamily: 'Manrope',
                                        //           fontWeight: FontWeight.w700,
                                        //           color: kTextColor,
                                        //           fontSize: 14.sp),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
              itemCount: widget.state.length,
            ),

            // : AnimatedContainer(
            //   duration: Duration(seconds: 1),
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   width: 140,
            //   height: 0 == index ? 200 : 100,
            //   color: Colors.red,
            // ),
          ),
        ],
      ),
    );
  }
}
