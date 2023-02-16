import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/i_heard_bob/i_heard_bob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/heard_page/home_state.dart';
import '../../bob_sightings/bob_sightings.dart';
import '../../common_widget/bottom_buttons.dart';
import '../../common_widget/custom_back_button.dart';
import '../../common_widget/custom_title.dart';

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
            leadingWidth: getProportionateScreenWidth(80),
            leading: const CustomBackButton(),
            title: SvgPicture.asset(
              "assets/images/logo-bobscapes.svg",
              height: 34.23,
            ),
          ),
          body: Stack(
              //alignment: Alignment.,
             // fit: StackFit.loose,
              children: [
                SizedBox(height: SizeConfig.screenHeight, width: SizeConfig.screenWidth,),
                Positioned.fill(
                  child: Opacity(
                    opacity: 1,
                    child: SvgPicture.asset("assets/images/sfondo3.svg",
                        fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenHeight(140),
                  left: 40,
                  right: 30,
                  child: Image.asset(
                    "assets/images/quail.png",
                    height: getProportionateScreenHeight(125),
                    alignment: Alignment.centerRight,
                  ),
                ),
                Positioned(
                  left: 15,
                  right: 15,
                  top: getProportionateScreenHeight(240),
                  child: Container(
                      height: 240,
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
                                padding: EdgeInsets.symmetric(vertical: 0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        "assets/icons/icon-close.svg",
                                        height: 20,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.title,
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Spacer(
                                      flex: 6,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      8)),
                                          child: SliderTheme(
                                            data: SliderThemeData(
                                                trackHeight: 2,
                                                inactiveTrackColor:
                                                    kTextColor.withOpacity(0.8),
                                                activeTrackColor: kColor1,
                                                disabledThumbColor: kColor1,
                                                thumbShape: SliderComponentShape
                                                    .noThumb,
                                                overlayShape:
                                                    const RoundSliderOverlayShape(
                                                        overlayRadius: 12),
                                                overlayColor:
                                                    Colors.transparent),
                                            child: Slider(
                                                min: 0,
                                                value: position.inSeconds
                                                    .toDouble(),
                                                max: duration.inSeconds
                                                    .toDouble(),
                                                onChanged: (value) async {
                                                  final position = Duration(
                                                      seconds: value.toInt());
                                                  await audioPlayer
                                                      .seek(position);
                                                }),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      20)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formatTime(position),
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize:
                                                        16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                formatTime(
                                                  duration - position,
                                                ),
                                                style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(flex: 2),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await audioPlayer
                                                .seek(Duration.zero);
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
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          8),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          8)),
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
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          8),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          8)),
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
                                    const Spacer(
                                      flex: 5,
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
                        onPressed: () => Navigator.popAndPushNamed(
                            context, BobSightingsScreen.routeName),
                      ),
                      BottomButton(
                          color: kColor2,
                          title: "Hey, I heard Bob!",
                          iconPath: "assets/icons/gps.svg",
                          onPressed: () {
                            if (Provider.of<HomeState>(context, listen: false)
                                .firstAccess) {
                              changeFirstAccess();
                              showDialog(
                                  barrierDismissible: false,
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) =>
                                      _showDisclaimer(context));

                              timer = Timer(const Duration(seconds: 25), () {
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(
                                    context, IHeardBobScreen.routeName);
                              });
                            } else {
                              Navigator.popAndPushNamed(
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
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: kAppbarColor,
            leading: Container(),
            title: SvgPicture.asset(
              "assets/images/logo-bobscapes.svg",
              height: 34.23,
            ),
          ),
          body: Stack(children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/images/sfondo-welcome2.svg",
                fit: BoxFit.fill,
                width: SizeConfig.screenWidth,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Positioned(
                    bottom: getProportionateScreenHeight(400),
                    left: 25,
                    child: Image.asset(
                      "assets/images/quail-reflected.png",
                      height: getProportionateScreenHeight(200),
                    ),
                  ),
                  Positioned(
                    height: getProportionateScreenHeight(525 - 72),
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(30),
                                      right: getProportionateScreenWidth(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Navigator.popAndPushNamed(context,
                                              IHeardBobScreen.routeName);
                                          setState(() {
                                            timer.cancel();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(30),
                                        top: getProportionateScreenHeight(20),
                                        bottom: getProportionateScreenHeight(5),
                                        right: getProportionateScreenWidth(40)),
                                    child: Text(
                                      "The exact location of your sightings will not be shared with the public.",
                                      style: TextStyle(
                                          color: kTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: getProportionateScreenWidth(
                                              14.5)),
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
                                          color: kTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              getProportionateScreenHeight(
                                                  14.5)),
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                ])),
          ]),
        ));
  }
}
