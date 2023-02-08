import 'package:bobscapes/constants.dart';
import 'package:bobscapes/provider/heard_page/heard_page1_state.dart';
import 'package:bobscapes/size_config.dart';
import 'package:bobscapes/views/bob_sightings/components/maps.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

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

  void changeLocation(String location) {
    context.read<HeardPage1State>().changeLocation(location);
  }

  void _initialization() {
    String location =
        Provider.of<HeardPage1State>(context, listen: false).location;

    if (location != '') controller = TextEditingController(text: location);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                //left: getProportionateScreenWidth(15),
                bottom: getProportionateScreenWidth(4),
                top: getProportionateScreenHeight(10)),
            child: Row(
              children: [
                Text(
                  "Latitude/Longitude",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w500,
                      color: kTextColor),
                ),
                const Spacer(),
                InkWell(
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  splashColor: Colors.transparent,
                  onTap: () => _showMap(),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/icon-edit.svg",
                        height: getProportionateScreenHeight(12),
                        color: kColor1,
                      ),
                    ],
                  ),
                ),
                InkWell(
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    splashColor: Colors.transparent,
                    onTap: () => _showMap(),
                    child: Text(
                      "change",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.w700,
                          color: kTextColor),
                    )),
              ],
            ),
          ),
          Row(children: [
            Expanded(
              child: Form(
                  child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: getProportionateScreenWidth(14)),
                      cursorColor: kTextColor,
                      controller: controller,
                      readOnly: true,
                      onSaved: (newValue) {
                        //  location = newValue ?? "";
                      },
                      onChanged: (value) {},
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withAlpha(200),
                        // TODO
                        contentPadding: EdgeInsets.all(
                          getProportionateScreenWidth(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            gapPadding: 20,
                            borderSide: const BorderSide(
                                color: kTextColor, width: 0.3)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: kTextColor, width: 0.3),
                            borderRadius: BorderRadius.circular(0),
                            gapPadding: 20),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(5)
                              ),
                          child: SvgPicture.asset(
                            "assets/icons/icon-geolocalization.svg",
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                            maxHeight: getProportionateScreenHeight(28),
                            maxWidth: getProportionateScreenWidth(28)),
                        //suffixIconColor: Colors.white,
                        hintText: "",
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ]),
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
            bottom: getProportionateScreenHeight(75),
            top: getProportionateScreenHeight(75),
            left: getProportionateScreenWidth(30),
            right: getProportionateScreenWidth(30),
            child: FlutterMap(
              options: MapOptions(
                  onTap: (tapPosition, point) {
                    setState(() {
                      String latitude = convertLatLng(point.latitude, true);

                      String longitude = convertLatLng(point.longitude, false);
                      String location = '$latitude/$longitude';
                      changeLocation(point.latitude.toString());
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
                  bottom: getProportionateScreenHeight(10),
                  left: getProportionateScreenWidth(10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(41),
                        height: getProportionateScreenHeight(41),
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
                                  changeLocation(point.latitude.toString());
                                  controller.text = location;
                                  Navigator.of(context).pop();
                                });
                              });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/gpsArrow.svg",
                              //  color: _liveUpdate ? kColor2 : Colors.white,
                              color: kColor1,
                              height: getProportionateScreenHeight(30),
                              width: getProportionateScreenWidth(30),
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
    // setState(() {
    //   String location = 'prova';
    //   changeLocation(location);
    //   controller.text = location;
    // });
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Serivce are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
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
