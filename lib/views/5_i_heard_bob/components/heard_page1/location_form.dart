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
  List<Marker> markers = [];

  late Marker current;
  late LatLng currentLatLng = LatLng(45, -120);

  bool getPosition = false;

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

    if (location != '') {
      controller = TextEditingController(text: location);
      String latitude =
          Provider.of<HeardPage1State>(context, listen: false).latitude;
      String longitude =
          Provider.of<HeardPage1State>(context, listen: false).longitude;
      currentLatLng = LatLng(
        double.parse(latitude),
        double.parse(longitude),
      );

      current = Marker(
        height: 75,
        width: 75,
        point: currentLatLng,
        // Usa il parametro child invece di builder
        child: SvgPicture.asset(
          "assets/icons/icon-pointer.svg",
        ),
      );

    } else {
      dynamic point = LatLng(45, -120);
      dynamic result = await _getLocation();
      if (result != null) {
        point = result;
        getPosition = true;
      }

      String latitude = convertLatLng(point.latitude, true);

      String longitude = convertLatLng(point.longitude, false);
      String liveLocation = '$latitude/$longitude';
      point.latitude.toString();
      changeLocation(liveLocation, point.latitude.toStringAsFixed(3),
          point.longitude.toStringAsFixed(3));

      controller = TextEditingController(text: liveLocation);
      currentLatLng = LatLng(point.latitude, point.longitude);
      current = Marker(
        height: 75,
        width: 75,
        point: currentLatLng,
        // Sostituisci builder con child
        child: SvgPicture.asset(
          result != null
              ? "assets/icons/icon-pin-here.svg"
              : "assets/icons/icon-pointer.svg",
        ),
      );
    }

    // current = Marker(
    //     height: 75,
    //     width: 75,
    //     point: currentLatLng,
    //     builder: (BuildContext context) {
    //       return SvgPicture.asset(
    //         "assets/icons/icon-pin-here.svg",
    //       );
    //     });
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
    // markers.add(current);
    LatLng pin = currentLatLng;
    showDialog(
        useSafeArea: false,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: kColor3,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                  ),
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
                              fontSize: 18.sp,
                            ),
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
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Flexible(
                        child: FlutterMap(
                          options: MapOptions(
                              onTap: (tapPosition, point) {
                                markers.removeWhere((marker) {
                                  if (getPosition) {
                                    return marker != current;
                                  } else {
                                    return true;
                                  }
                                });
                               Marker marker = Marker(
                                alignment: Alignment.topCenter,
                                height: 75,
                                width: 75,
                                point: point,
                                // Usa child invece di builder
                                child: SvgPicture.asset(
                                  "assets/icons/icon-pointer.svg",
                                ),
                              );

                                markers.add(marker);
                                pin = point;
                                currentLatLng = pin;
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
                              
                              initialCameraFit: CameraFit.bounds(bounds: LatLngBounds(
                                  LatLng(0, -180.0), LatLng(75, -40.781693))),
                              minZoom: 3,
                              maxZoom: 18,
                              initialCenter: currentLatLng,
                                initialZoom: 15,
                               interactionOptions: InteractionOptions(flags: InteractiveFlag.all &
                                  ~InteractiveFlag.rotate)),
                          children: [
                            // AttributionWidget.defaultWidget(
                            //   source: 'OpenStreetMap contributors',
                            //   onSourceTapped: null,
                            // ),
                            TileLayer(
                              // backgroundColor: Colors.white,
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
                                          dynamic point = await _getLocation();
                                          if (point == null) {
                                            print('Print');
                                            LocationPermission permission =
                                                await Geolocator
                                                    .checkPermission();

                                            if (permission ==
                                                    LocationPermission.denied ||
                                                permission ==
                                                    LocationPermission
                                                        .deniedForever) {
                                              print('Print2');
                                              await Geolocator
                                                  .requestPermission();
                                              permission = await Geolocator
                                                  .checkPermission();
                                              if (permission ==
                                                  LocationPermission.denied) {
                                                // await Geolocator
                                                // .requestPermission();
                                              }
                                            }
                                            print("Print3");
                                          }
                                          currentLatLng = LatLng(
                                              point.latitude, point.longitude);
                                         current = Marker(
                                          height: 75,
                                          width: 75,
                                          point: currentLatLng,
                                          // Utilizza il parametro child
                                          child: SvgPicture.asset(
                                            "assets/icons/icon-pin-here.svg",
                                          ),
                                        );
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

  Future<dynamic> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Serivce are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return null;
        // return Future.error("Location permission are denied");
      } else {
        Position position = (await Geolocator.getCurrentPosition());
        print(position.latitude);
        print(position.longitude);

        //currentLatLng = LatLng(position.latitude, position.longitude);
        //if (current != null && markers.contains(current)) markers.remove(current);

        return position;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return null;
      // return Future.error("Location permission are permanently denied");
    } else {
      Position position = (await Geolocator.getCurrentPosition());
      print(position.latitude);
      print(position.longitude);
      //currentLatLng = LatLng(position.latitude, position.longitude);
      //if (current != null && markers.contains(current)) markers.remove(current);

      return position;
    }
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
