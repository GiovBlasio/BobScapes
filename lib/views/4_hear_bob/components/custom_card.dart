import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.title,
    required this.time,
    required this.path,
    Key? key,
  }) : super(key: key);

  final String title;
  final String time;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: Container(
            color: kColor3,
            width: double.infinity,
          //  height: 358.h,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.blue,
                  padding: EdgeInsets.only(left: 65.w),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: Image.asset(
                          path,
                          width: ScreenUtil().screenWidth,
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        shape: const CircleBorder(),
                        elevation: 8,
                        child: Container(
                            height: 45.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
                            child: SvgPicture.asset(
                              "assets/icons/icon-sound.svg",
                              height: 20.h,
                            )),
                      ),
                      Container(
                        //width: 245,
                        margin: EdgeInsets.only(left: 25.w),
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 17.5.sp,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w700,
                                  color: kTextColor),
                            ),
                            Text(
                              '$time s',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
