import 'package:bobscapes/constants.dart';
import 'package:bobscapes/services/remote_services.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bobscapes/models/marker.dart' as model;

import '../../common_widget/disclaimer.dart';

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
          //screenSize: ,
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
          bottom: getProportionateScreenHeight(85),
          right: getProportionateScreenWidth(10),
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                iconSize: getProportionateScreenHeight(25),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.zero,
                  onPressed: () => showDialog(
                      useSafeArea: false,
                      barrierColor: Colors.white70,
                      context: context,
                      builder: (context) => const Disclaimer()),
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  )),
              SizedBox(
                width: getProportionateScreenWidth(41),
                height: getProportionateScreenHeight(41),
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: _liveUpdate ? Colors.white : kColor2,
                    onPressed: () {
                      _getLocation().then((value) => currentLatLng =
                          LatLng(value.latitude, value.longitude));
                      // liveLocation();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/gpsArrow.svg",
                      color: _liveUpdate ? kColor2 : Colors.white,
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
        height: element.sightings < 9
            ? 40
            : element.sightings < 25
                ? 45
                : 55,
        width: element.sightings < 9
            ? 40
            : element.sightings < 13
                ? 45
                : 55,
        point: LatLng(element.latitude, element.longitude),
        builder: (context) => GestureDetector(
          onTap: () => _showBottomSheet(context, element.state),
          child: SvgPicture.asset(
            "assets/icons/pin pieno.svg",
            height: element.sightings < 9
                ? 40
                : element.sightings < 25
                    ? 45
                    : 55,
            width: element.sightings < 9
                ? 40
                : element.sightings < 13
                    ? 45
                    : 55,
            color: element.state.length < 9
                ? kColor1
                : element.state.length < 13
                    ? kColor2
                    : kColor3,
          ),
        ),
      );

      state.add(element.state);
      sightings.add(element.sightings);
      markers.add(marker);
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
      Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    position = (await Geolocator.getCurrentPosition());

    currentLatLng = LatLng(position.latitude, position.longitude);
    if (current != null && markers.contains(current)) markers.remove(current);
    current = Marker(
        height: 60,
        width: 60,
        point: currentLatLng,
        builder: (BuildContext context) {
          return Center(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColor1.withOpacity(0.5),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColor1,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    markers.add(current!);
    setState(() {
      _mapController.move(currentLatLng, zoom);
      _liveUpdate = !_liveUpdate;
    });
    return position;
  }

  // void liveLocation() {
  //   LocationSettings settings = const LocationSettings(
  //       accuracy: LocationAccuracy.high, distanceFilter: 100);
  //   Geolocator.getPositionStream(locationSettings: settings).listen((position) {
  //     setState(() {
  //       currentLatLng = LatLng(position.latitude, position.longitude);
  //       _mapController.move(currentLatLng, 5.5);
  //     });
  //   });
  // setState(() {});
  // }

  void _showBottomSheet(BuildContext context, String key) {
    int index = state.indexOf(key);
    showBottomSheet(
        backgroundColor: const Color.fromARGB(150, 158, 158, 158),
        context: context,
        builder: (ctx) {
          return BottomSheetCards(
              state: state, item: index, sightings: sightings);
        });
  }
}

class BottomSheetCards extends StatefulWidget {
  const BottomSheetCards({
    super.key,
    required this.state,
    required this.item,
    required this.sightings,
  });

  final List<String> state;
  final int item;
  final List<int> sightings;

  @override
  State<BottomSheetCards> createState() => _BottomSheetCardsState();
}

class _BottomSheetCardsState extends State<BottomSheetCards> {
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(8),
          ),
          height: getProportionateScreenHeight(4),
          width: getProportionateScreenWidth(100),
        ),
        CarouselSlider.builder(
          itemCount: widget.state.length,
          options: CarouselOptions(
              initialPage: widget.item,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enlargeFactor: 0.45,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index % widget.state.length;
                });
              },
              aspectRatio: 1.8,
              enlargeCenterPage: true,
              viewportFraction: 0.52),
          itemBuilder: (context, index, realIdx) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(
                  minWidth: 120,
                ),
                decoration: BoxDecoration(
                    color: currentIndex == index ? kColor1 : Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.state[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(14)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Bob has\nbeen heard",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisSize: MainAxisSize.min,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "${widget.sightings[index]}",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(40),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(45),
                        ),
                        Text(
                          "times",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: getProportionateScreenHeight(18),
        )
      ],
    );
  }
}
