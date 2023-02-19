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
    } else {
      Position point = await _getLocation();

      String latitude = convertLatLng(point.latitude, true);

      String longitude = convertLatLng(point.longitude, false);
      String liveLocation = '$latitude/$longitude';
      changeLocation(liveLocation, point.latitude.toStringAsFixed(3),
          point.longitude.toStringAsFixed(3));

      controller = TextEditingController(text: liveLocation);
      setState(() {});
    }
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
    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Positioned(
            bottom: 75.h,
            top: 75.h,
            left: 30.w,
            right: 30.w,
            child: FlutterMap(
              options: MapOptions(
                  onTap: (tapPosition, point) {
                    setState(() {
                      String latitude = convertLatLng(point.latitude, true);

                      String longitude = convertLatLng(point.longitude, false);
                      String location = '$latitude/$longitude';
                      changeLocation(
                          location,
                          point.latitude.toStringAsFixed(3),
                          point.longitude.toStringAsFixed(3));
                      controller.text = location;
                    });
                    Navigator.of(context).pop();
                  },
                  maxBounds:
                      LatLngBounds(LatLng(0, -180.0), LatLng(75, -40.781693)),
                  minZoom: 3.5,
                  maxZoom: 18,
                  center: LatLng(45, -120),
                  zoom: 5,
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate),
              children: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
                TileLayer(
                  backgroundColor: Colors.white,
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
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
                            onPressed: () {
                              _getLocation().then((point) {
                                setState(() {
                                  String latitude =
                                      convertLatLng(point.latitude, true);

                                  String longitude =
                                      convertLatLng(point.longitude, false);
                                  String location = '$latitude/$longitude';
                                  changeLocation(
                                      location,
                                      point.latitude.toString(),
                                      point.longitude.toString());
                                  controller.text = location;
                                  Navigator.of(context).pop();
                                });
                              });
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
        ],
      ),
    );
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
