import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../provider/heard_page/home_state.dart';
import '../../5_i_heard_bob/i_heard_bob.dart';
import '../../7_bob_sightings_map/bob_sightings.dart';
import '../../common_widget/bottom_buttons.dart';
import '../../common_widget/custom_back_button.dart';
import '../../common_widget/custom_title.dart';
import '../../common_widget/title_back.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({
    required this.title,
    required this.path,
    Key? key,
  }) : super(key: key);

  final String title;
  final String path;

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  late Timer timer;

  void changeFirstAccess() {
    context.read<HomeState>().changeFirstAccess();
  }

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: kAppbarColor,
              leadingWidth: 80.w,
              leading: const CustomBackButton(),
              title: const TitleBack()),
          body: Stack(children: [
            SizedBox(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
            ),
            Positioned.fill(
              child: Opacity(
                opacity: 1,
                child: SvgPicture.asset(
                  "assets/images/sfondo3.svg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: 118.h,
              right: 16.w,
              child: Image.asset(
                "assets/images/quail.png",
                height: 0.15.sh,
                alignment: Alignment.centerRight,
              ),
            ),
            Positioned(
              left: 16.w,
              right: 16.w,
              top: 216.h,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      elevation: 10,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(13),
                          ),
                          child: Container(
                            color: kColor3,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10.w,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/icon-close.svg",
                                      height: 24.h,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Text(
                                        widget.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: kTextColor,
                                            fontSize: 22.sp,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 47.5.h,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                            trackHeight: 2,
                                            inactiveTrackColor:
                                                kTextColor.withOpacity(0.8),
                                            activeTrackColor: kColor1,
                                            disabledThumbColor: kColor1,
                                            thumbShape:
                                                SliderComponentShape.noThumb,
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                                    overlayRadius: 12),
                                            overlayColor: Colors.transparent),
                                        child: Slider(
                                            min: 0,
                                            value:
                                                position.inSeconds.toDouble(),
                                            max: duration.inSeconds.toDouble(),
                                            onChanged: (value) async {
                                              final position = Duration(
                                                  seconds: value.toInt());
                                              await audioPlayer.seek(position);
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatTime(position),
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontSize: 14.sp,
                                                fontFamily: 'Manrope',
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            formatTime(
                                              duration - position,
                                            ),
                                            style: TextStyle(
                                                color: kTextColor,
                                                fontSize: 14.sp,
                                                fontFamily: 'Manrope',
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 27.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await audioPlayer.seek(Duration.zero);
                                        audioPlayer.stop();
                                        setState(() {
                                          position = Duration.zero;

                                          isPlaying = false;
                                        });
                                      },
                                      child: Card(
                                        shape: const CircleBorder(),
                                        elevation: 8,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 8.h,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/icon-repeate.svg",
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (isPlaying) {
                                          await audioPlayer.pause();
                                        } else {
                                          await audioPlayer.resume();
                                        }
                                        setState(() {
                                          isPlaying = !isPlaying;
                                        });
                                      },
                                      child: Card(
                                        shape: const CircleBorder(),
                                        elevation: 8,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 8.h,
                                          ),
                                          child: !isPlaying
                                              ? const Icon(
                                                  Icons.play_arrow,
                                                  color: kTextColor,
                                                  size: 20,
                                                )
                                              : SvgPicture.asset(
                                                  "assets/icons/icon-stop.svg",
                                                  height: 20,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 32.h,
                                )
                              ],
                            ),
                          )))),
            ),
            const CustomTitle(
              title: "Hear Bob",
              color: kColor1,
              icon: "assets/icons/music.svg",
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  BottomButton(
                      color: kColor3,
                      title: "Bob Sightings Map",
                      iconPath: "assets/icons/eye.svg",
                      onPressed: () {
                        audioPlayer.stop();
                        Navigator.pushNamed(
                            context, BobSightingsScreen.routeName);
                      }),
                  BottomButton(
                      color: kColor2,
                      title: "Hey, I heard Bob!",
                      iconPath: "assets/icons/gps.svg",
                      onPressed: () {
                        audioPlayer.stop();
                        if (Provider.of<HomeState>(context, listen: false)
                            .firstAccess) {
                          changeFirstAccess();

                          showDialog(
                              useSafeArea: false,
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => _showDisclaimer(context));

                          timer = Timer(const Duration(seconds: 25), () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, IHeardBobScreen.routeName);
                          });
                        } else {
                          Navigator.pushNamed(
                              context, IHeardBobScreen.routeName);
                        }
                      }),
                ],
              ),
            ),
          ]),
        ));
  }

  String formatTime(Duration duration) {
    String twoDigits(int n, int pad) => n.toString().padLeft(pad, '0');
    final hours = twoDigits(duration.inHours, 1);
    final minutes = twoDigits(duration.inMinutes.remainder(60), 1);
    final seconds = twoDigits(duration.inSeconds.remainder(60), 2);

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    final player = AudioCache(prefix: "assets/music/");

    final url = await player.load(widget.path);
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  Widget _showDisclaimer(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kAppbarColor,
            leadingWidth: 80.w,
            leading: const CustomBackButton(),
            title: const TitleBack()),
        body: Stack(children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    "assets/images/sfondo-welcome2.svg",
                    fit: BoxFit.cover,
                    //   width: ScreenUtil().screenWidth,
                  ),
                ),
                Positioned(
                  bottom: 400.h,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/quail-reflected.png",
                    height: 270.h,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Positioned(
                  height: 453.h,
                  left: 16.w,
                  right: 16.w,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.symmetric(horizontal: 0.h),
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                            color: kColor3,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 30.w, right: 10.w),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "Disclaimer",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.sp),
                                    ),
                                    IconButton(
                                      splashRadius: 0.1,
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                        color: kTextColor,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, IHeardBobScreen.routeName);
                                        setState(() {
                                          timer.cancel();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 30.w,
                                          top: 25.h,
                                          bottom: 5.h,
                                          right: 40.w,
                                        ),
                                        child: Text(
                                          "The exact location of your sightings will not be shared with the public.",
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 30.w,
                                          top: 15.h,
                                          bottom: 5.h,
                                          right: 40.w,
                                        ),
                                        child: Text(
                                          "Any personal sighting information you share will only be used internally to inform management recommendations with our conservation partners: Quail Forever, USDA's NRCS, and University of Georgia Martin Game Lab.",
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontFamily: 'Manrope',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ])),
        ]),
      ),
    );
  }
}
