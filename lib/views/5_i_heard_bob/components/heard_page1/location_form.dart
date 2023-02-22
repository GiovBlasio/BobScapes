// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/heard_page/heard_page1_state.dart';

class LocationForm extends StatefulWidget {
  const LocationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  TextEditingController controller = TextEditingController();

  late Marker current;
  late LatLng currentLatLng = LatLng(45, -120);

  @override
  void initState() {
    _initialization();
    super.initState();
  }

  void changeLocation(String location, String latitude, String longitude) {
    context.read<HeardPage1State>().changeLatitude(latitude);
    context.read<HeardPage1State>().changeLongitude(longitude);
    context.read<HeardPage1State>().changeLocation(location);
  }

  void _initialization() async {
    String location =
        Provider.of<HeardPage1State>(context, listen: false).location;
    Position point = await _getLocation();
    if (location != '') {
      controller = TextEditingController(text: location);
    } else {
      String latitude = convertLatLng(point.latitude, true);

      String longitude = convertLatLng(point.longitude, false);
      String liveLocation = '$latitude/$longitude';
      changeLocation(liveLocation, point.latitude.toStringAsFixed(3),
          point.longitude.toStringAsFixed(3));

      controller = TextEditingController(text: liveLocation);
    }
    currentLatLng = LatLng(point.latitude, point.longitude);
    current = Marker(
        height: 75,
        width: 75,
        point: currentLatLng,
        builder: (BuildContext context) {
          return SvgPicture.asset(
            "assets/icons/icon-pin-here.svg",
          );
        });
    // markers.add(current);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
            ),
            child: Row(
              children: [
                Text(
                  "Latitude/Longitude",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    color: kTextLightColor,
                  ),
                ),
                const Spacer(),
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  splashColor: Colors.transparent,
                  onTap: () => _showMap(),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon-edit.svg",
                            height: 14,
                            color: kColor1,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "change",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            color: kTextColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Form(
                    child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        onTap: () => _showMap(),
                        style: TextStyle(
                            color: kTextColor,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp),
                        cursorColor: kTextColor,
                        controller: controller,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withAlpha(200),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            gapPadding: 20,
                            borderSide: BorderSide(
                              color: kTextColor.withOpacity(0.22),
                              width: .5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            gapPadding: 4,
                            borderSide: BorderSide(
                              color: kTextColor.withOpacity(0.22),
                              width: .5,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kTextColor.withOpacity(0.22),
                                  width: 0.3),
                              borderRadius: BorderRadius.circular(5),
                              gapPadding: 4),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: SvgPicture.asset(
                              "assets/icons/icon-geolocalization.svg",
                            ),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(maxHeight: 28.w, maxWidth: 28.w),
                          hintText: "",
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showMap() {
    List<Marker> markers = [];
    markers.add(current);
    LatLng pin = currentLatLng;
    showDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                bottom: 75.h,
                top: 75.h,
                left: 30.w,
                right: 30.w,
                child: Container(
                  color: kColor3,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Register your sighting",
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w700,
                                color: kTextColor,
                                fontSize: 18.sp),
                          ),
                          const Spacer(),
                          Flexible(
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.grey),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   "Next",
                                  //   style: TextStyle(
                                  //     fontSize: 14.sp,
                                  //     color: kTextColor,
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 5.w,
                                  // ),
                                  SvgPicture.asset(
                                    "assets/icons/icon-close.svg",
                                    height: 14,
                                  )
                                ],
                              ),
                            ),
                          ),

                          // IconButton(
                          //   splashRadius: 0.1,
                          //   icon: const Icon(
                          //     Icons.close,
                          //     size: 30,
                          //     color: kTextColor,
                          //   ),
                          //   onPressed: () {
                          //     // if (!isLoaded) {
                          //     //   setState(() {
                          //     //     pageController.animateToPage(
                          //     //         currentIndex + 1,
                          //     //         duration: const Duration(seconds: 1),
                          //     //         curve: Curves.linear);
                          //     //   });
                          //     // }
                          //   },

                          //  ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Flexible(
                        child: FlutterMap(
                          options: MapOptions(
                              onTap: (tapPosition, point) {
                                markers.removeWhere(
                                    (marker) => (marker != current));
                                Marker marker = Marker(
                                    anchorPos: AnchorPos.align(AnchorAlign.top),
                                    height: 75,
                                    width: 75,
                                    point: point,
                                    builder: (BuildContext context) {
                                      return SvgPicture.asset(
                                        "assets/icons/icon-pointer.svg",
                                      );
                                    });
                                markers.add(marker);
                                pin = point;
                                // setState(() {
                                //   String latitude =
                                //       convertLatLng(point.latitude, true);

                                //   String longitude =
                                //       convertLatLng(point.longitude, false);
                                //   String location = '$latitude/$longitude';
                                //   changeLocation(
                                //       location,
                                //       point.latitude.toStringAsFixed(3),
                                //       point.longitude.toStringAsFixed(3));
                                //   controller.text = location;
                                // });

                                //Navigator.of(context).pop();
                              },
                              maxBounds: LatLngBounds(
                                  LatLng(0, -180.0), LatLng(75, -40.781693)),
                              minZoom: 3,
                              maxZoom: 18,
                              center: currentLatLng,
                              zoom: 15,
                              interactiveFlags: InteractiveFlag.all &
                                  ~InteractiveFlag.rotate),
                          children: [
                            AttributionWidget.defaultWidget(
                              source: 'OpenStreetMap contributors',
                              onSourceTapped: null,
                            ),
                            TileLayer(
                              backgroundColor: Colors.white,
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: markers,
                            ),
                            Positioned(
                              bottom: 10.h,
                              left: 10.w,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 41.w,
                                    height: 41.w,
                                    child: FittedBox(
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        onPressed: () async {
                                          Position point = await _getLocation();

                                          currentLatLng = LatLng(
                                              point.latitude, point.longitude);
                                          current = Marker(
                                              height: 75,
                                              width: 75,
                                              point: LatLng(point.latitude,
                                                  point.longitude),
                                              builder: (BuildContext context) {
                                                return SvgPicture.asset(
                                                  "assets/icons/icon-pin-here.svg",
                                                );
                                              });
                                          markers.add(current);
                                          setState(() {});
                                          // setState(() {
                                          //   String latitude = convertLatLng(
                                          //       point.latitude, true);

                                          //   String longitude = convertLatLng(
                                          //       point.longitude, false);
                                          //   String location =
                                          //       '$latitude/$longitude';
                                          //   changeLocation(
                                          //       location,
                                          //       point.latitude.toString(),
                                          //       point.longitude.toString());
                                          //   controller.text = location;
                                          //   // Navigator.of(context).pop();
                                          // });
                                        },
                                        child: SvgPicture.asset(
                                          "assets/icons/icon-geolocalization.svg",
                                          color: kColor1,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.grey),
                              backgroundColor:
                                  MaterialStateProperty.all(kAppbarColor),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                // SvgPicture.asset(
                                //   "assets/icons/icon-back-form.svg",
                                //   height: 14,
                                // ),
                                // SizedBox(
                                //   width: 5.w,
                                // ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.grey),
                              backgroundColor:
                                  MaterialStateProperty.all(kAppbarColor),
                            ),
                            onPressed: () {
                              setState(() {
                                String latitude =
                                    convertLatLng(pin.latitude, true);

                                String longitude =
                                    convertLatLng(pin.longitude, false);
                                String location = '$latitude/$longitude';
                                changeLocation(
                                    location,
                                    pin.latitude.toStringAsFixed(3),
                                    pin.longitude.toStringAsFixed(3));
                                controller.text = location;
                              });

                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                // SvgPicture.asset(
                                //   "assets/icons/icon-back-form.svg",
                                //   height: 14,
                                // ),
                                // SizedBox(
                                //   width: 5.w,
                                // ),
                                Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Serivce are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    Position position = (await Geolocator.getCurrentPosition());

    //currentLatLng = LatLng(position.latitude, position.longitude);
    //if (current != null && markers.contains(current)) markers.remove(current);

    return position;
  }

  String convertLatLng(double decimal, bool isLat) {
    String degree = "${decimal.toString().split(".")[0]}°";
    double minutesBeforeConversion =
        double.parse("0.${decimal.toString().split(".")[1]}");
    String minutes =
        "${(minutesBeforeConversion * 60).toString().split('.')[0]}'";
    double secondsBeforeConversion = double.parse(
        "0.${(minutesBeforeConversion * 60).toString().split('.')[1]}");
    String seconds =
        '${double.parse((secondsBeforeConversion * 60).toString()).toStringAsFixed(2)}" ';
    String dmsOutput =
        "$degree $minutes $seconds ${isLat ? decimal > 0 ? 'N' : 'S' : decimal > 0 ? 'E' : 'W'}";
    return dmsOutput;
  }
}
