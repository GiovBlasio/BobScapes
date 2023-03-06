import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '/views/7_bob_sightings_map/components/bottom_sheet.dart';
import '../../../constants.dart';
import '../../../services/remote_services.dart';
import '/models/marker.dart' as model;

class Mappa extends StatefulWidget {
  const Mappa({
    Key? key,
  }) : super(key: key);

  @override
  State<Mappa> createState() => _MappaState();
}

class _MappaState extends State<Mappa> {
  final MapController _mapController = MapController();
  LatLng currentLatLng = LatLng(32.3668052, -86.2999689);
  late Position position;
  bool _liveUpdate = false;

  double zoom = 5.9;
  final List<Marker> markers = [];
  List<String> state = [];
  List<int> sightings = [];

  Marker? current;

  late List<model.Marker> markers2;

  @override
  void initState() {
    _initialization();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          onMapEvent: (event) {
            zoom = event.zoom;
          },
          maxBounds: LatLngBounds(LatLng(0, -180.0), LatLng(75, -40.781693)),
          minZoom: 3.5,
          maxZoom: 18,
          center: currentLatLng,
          zoom: zoom,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate),
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
        MarkerLayer(
          markers: markers,
        ),
        Positioned(
          bottom: 100.h,
          right: 10.w,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //     iconSize: getProportionateScreenHeight(25),
              //     alignment: Alignment.bottomCenter,
              //     padding: EdgeInsets.zero,
              //     onPressed: () => showDialog( useSafeArea: false,
              //         useSafeArea: false,
              //         barrierColor: Colors.white70,
              //         context: context,
              //         builder: (context) => Padding(
              //               padding: EdgeInsets.zero,
              //               child: _showDisclaimer(context),
              //             )),
              //     icon: const Icon(
              //       Icons.info_outline,
              //       color: Colors.white,
              //     )),
              SizedBox(
                width: 54.h,
                height: 54.h,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _getLocation().then((value) => currentLatLng =
                          LatLng(value.latitude, value.longitude));
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
    );
  }

  _initialization() async {
    markers2 = await RemoteService().getMarker();

    _buildMarkers();
    setState(() {});
  }

  void _buildMarkers() {
    for (model.Marker element in markers2) {
      Marker marker = Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        height: 50.h,
        width: 50.h,
        point: LatLng(element.latitude, element.longitude),
        builder: (context) => GestureDetector(
          onTap: () => _showBottomSheet(context, element.state),
          child: SvgPicture.asset(
            "assets/icons/icon-pointer.svg",
            color: kColor1,
          ),
        ),
      );

      state.add(element.state);
      sightings.add(element.sightings);
      markers.add(marker);
      _getLocation();
    }

    markers.sort((a, b) => b.point.latitude.compareTo(a.point.latitude));
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

    position = await Geolocator.getCurrentPosition();

    currentLatLng = LatLng(position.latitude, position.longitude);
    if (current != null && markers.contains(current)) markers.remove(current);
    current = Marker(
        height: 75,
        width: 75,
        point: currentLatLng,
        builder: (BuildContext context) {
          return SvgPicture.asset(
            "assets/icons/icon-pin-here.svg",
          );
        });
    markers.add(current!);
    setState(() {
      _mapController.move(currentLatLng, zoom);
      _liveUpdate = !_liveUpdate;
    });
    return position;
  }

  void _showBottomSheet(BuildContext context, String key) {
    int index = state.indexOf(key);
    showBottomSheet(
        backgroundColor: const Color.fromARGB(150, 255, 255, 255),
        context: context,
        builder: (ctx) {
          return BottomSheetCards(
              state: state, item: index, sightings: sightings);
        });
  }

  // _showDisclaimer(BuildContext context) {
  //   return Stack(children: [
  //     Positioned(
  //         bottom: 0,
  //         left: 0,
  //         right: 0,
  //         top: 0,
  //         child: Stack(alignment: Alignment.bottomCenter, children: [
  //           Positioned(
  //             bottom: 400,
  //             left: 25,
  //             child: Image.asset(
  //               "assets/images/quail-reflected.png",
  //               height: 200,
  //             ),
  //           ),
  //           Positioned(
  //             height: 453,
  //             left: 25,
  //             right: 25,
  //             child: Card(
  //               shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.vertical(
  //                   top: Radius.circular(16),
  //                 ),
  //               ),
  //               elevation: 10,
  //               margin: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(0)),
  //               child: Container(
  //                   padding: EdgeInsets.symmetric(
  //                       vertical: getProportionateScreenHeight(15)),
  //                   decoration: const BoxDecoration(
  //                       color: kColor3,
  //                       borderRadius:
  //                           BorderRadius.vertical(top: Radius.circular(16))),
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: getProportionateScreenWidth(10)),
  //                     child: Column(
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(
  //                               left: getProportionateScreenWidth(30),
  //                               right: getProportionateScreenWidth(10)),
  //                           child: Row(
  //                             crossAxisAlignment: CrossAxisAlignment.baseline,
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             textBaseline: TextBaseline.alphabetic,
  //                             children: [
  //                               Text(
  //                                 "Disclaimer",
  //                                 style: TextStyle(
  //                                     color: kTextColor,
  //                                     fontFamily: 'Manrope',
  //                                     fontWeight: FontWeight.w600,
  //                                     fontSize: 20.sp),
  //                               ),
  //                               IconButton(
  //                                 splashRadius: 0.1,
  //                                 icon: const Icon(
  //                                   Icons.close,
  //                                   size: 30,
  //                                   color: kTextColor,
  //                                 ),
  //                                 onPressed: () {
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                         Padding(
  //                             padding: EdgeInsets.only(
  //                                 left: getProportionateScreenWidth(30),
  //                                 top: 30,
  //                                 bottom: 5,
  //                                 right: getProportionateScreenWidth(40)),
  //                             child: Text(
  //                               "The exact location of your sightings will not be shared with the public.",
  //                               style: TextStyle(
  //                                   color: kTextColor,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15.sp),
  //                             )),
  //                         Padding(
  //                             padding: EdgeInsets.only(
  //                                 left: getProportionateScreenWidth(30),
  //                                 top: 20,
  //                                 bottom: 5,
  //                                 right: getProportionateScreenWidth(40)),
  //                             child: Text(
  //                               "Any personal sighting information you share will only be used internally to inform management recommendations with our conservation partners: Quail Forever, USDA's NRCS, and University of Georgia Martin Game Lab.",
  //                               style: TextStyle(
  //                                   color: kTextColor,
  //                                   fontFamily: 'Manrope',
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15.sp),
  //                             )),
  //                       ],
  //                     ),
  //                   )),
  //             ),
  //           ),
  //         ]))
  //   ]);
  // }
}
