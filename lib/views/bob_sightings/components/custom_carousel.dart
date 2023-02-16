import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  // Timer? carasouelTmer;

  // Timer getTimer() {
  //   return Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (pageNo == 4) {
  //       pageNo = 0;
  //     }
  //     pageController.animateToPage(
  //       pageNo,
  //       duration: const Duration(seconds: 1),
  //       curve: Curves.easeInOutCirc,
  //     );
  //     pageNo++;
  //   });
  // }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.9, );
    //carasouelTmer = getTimer();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     showBtmAppBr = false;
    //     setState(() {});
    //   } else {
    //     showBtmAppBr = true;
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      // onTap: () {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text("Hello you tapped at ${index + 1} "),
                      //     ),
                      //   );
                      // },
                      // onPanDown: (d) {
                      //   // carasouelTmer?.cancel();
                      //   // carasouelTmer = null;
                      // },
                      // onPanCancel: () {
                      //   // carasouelTmer = getTimer();
                      // },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8, left: 8, top: 24, bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      size: 12.0,
                      color: pageNo == index
                          ? Colors.indigoAccent
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
