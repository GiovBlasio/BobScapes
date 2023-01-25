import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bobscapes/constants.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

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
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(35),
          horizontal: getProportionateScreenWidth(15)),
      child: Container(
          height: getProportionateScreenHeight(190),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 8,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 10,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  child: Container(
                    color: kPrimaryColor,
                    width: double.infinity,
                    //height: 350,
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(45),
                              right: getProportionateScreenWidth(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(8)),
                              child: SliderTheme(
                                data: SliderThemeData(
                                    trackHeight: 2,
                                    inactiveTrackColor:
                                        Colors.white.withOpacity(0.6),
                                    activeTrackColor: Colors.white,
                                    disabledThumbColor: Colors.white,
                                    thumbShape: SliderComponentShape.noThumb,
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 12),
                                    overlayColor: Colors.transparent),
                                child: Slider(
                                    min: 0,
                                    value: position.inSeconds.toDouble(),
                                    max: 100,
                                    // max: duration.inSeconds.toDouble(),
                                    onChanged: (value) async {
                                      final position =
                                          Duration(seconds: value.toInt());
                                      await audioPlayer.seek(position);
                                    }),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(position),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12),
                                  ),
                                  Text(
                                    formatTime(
                                      duration - position,
                                    ),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
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
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(8),
                                      vertical:
                                          getProportionateScreenHeight(8)),
                                  child: const Icon(Icons.repeat),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (() async {
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.resume();
                                }
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              }),
                              child: Card(
                                shape: const CircleBorder(),
                                elevation: 8,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(8),
                                      vertical:
                                          getProportionateScreenHeight(8)),
                                  child: Icon(isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )))),
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
    String path = "";
    File file = File(path);
    audioPlayer.setUrl(file.path, isLocal: true);
  }
}
