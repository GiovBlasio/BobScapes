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
      viewportFraction: 0.37,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
          maxHeight: 240.h,
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
                          //  color: Colors.red,
                          duration: const Duration(milliseconds: 750),
                          height: currentIndex == index % widget.state.length
                              ? 240.h
                              : 180.h,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              //duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(vertical: 0.h),
                              margin: EdgeInsets.only(
                                  left: 20.w,
                                  right: 13.w,
                                  top: 17.h,
                                  bottom: 3.h),
                              decoration: BoxDecoration(
                                  color: currentIndex ==
                                          index % widget.state.length
                                      ? kColor3
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.state[index % widget.state.length],
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w700,
                                      color: kTextColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Bob has\nbeen heard",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: kTextColor,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    mainAxisSize: MainAxisSize.min,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 42.sp,
                                            color: kTextColor,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w300,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${widget.sightings[index % widget.state.length]}",
                                            ),
                                            if (widget.sightings[index %
                                                        widget.state.length]
                                                    .toString()
                                                    .length ==
                                                1)
                                              TextSpan(
                                                  text: '1',
                                                  style: TextStyle(
                                                    fontSize: 42.sp,
                                                    color: kColor3,
                                                    fontFamily: 'Manrope',
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 23.w,
                                      ),
                                      Text(
                                        "times",
                                        style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w700,
                                            color: kTextColor,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
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
        SizedBox(
          height: 7.h,
        )
      ],
    );
  }
}
