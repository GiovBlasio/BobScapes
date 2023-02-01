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
import 'package:provider/provider.dart';

import '../../common_widget/disclaimer.dart';

class Mappa extends StatefulWidget {
  const Mappa({
    Key? key,
  }) : super(key: key);

  @override
  State<Mappa> createState() => _MappaState();
}

class _MappaState extends State<Mappa> {
  late final MapController _mapController = MapController();
  late LatLng currentLatLng = LatLng(32.3668052, -86.2999689);
  late Position position;
  bool _liveUpdate = false;

  Map<String, LatLng> usState = {
    'Montgomery': LatLng(32.3668052, -86.2999689),
    'Juneau': LatLng(58.301944, -134.419722),
    'Phoenix': LatLng(33.448377, -112.074037),
    'Little Rock': LatLng(34.746481, -92.289595),
    'Sacramento': LatLng(38.590576, -121.489906),
    'Raleigh': LatLng(35.884766, -78.625053),
    'Columbia': LatLng(34.000333332, -81.039833174),
    'Denver': LatLng(39.742043, -104.991531),
    'Hartford': LatLng(41.763710, -72.685097),
    'Dover': LatLng(39.157307, -75.519722),
    'Honolulu': LatLng(21.307442, -157.857376),
    'Tallahassee': LatLng(30.438118, -84.281296),
    'Atlanta': LatLng(33.749027, -84.388229),
    'Boise': LatLng(43.617775, -116.199722),
    'Springfield': LatLng(39.798363, -89.654961),
    'Indianapolis': LatLng(39.768623, -86.162643),
    'Des Moines': LatLng(41.591087, -93.603729),
    'Topeka': LatLng(39.048191, -95.677956),
    'Frankfort': LatLng(38.186722, -84.875374),
    'Baton Rouge': LatLng(30.457069, -91.187393),
    'Augusta': LatLng(44.307167, -69.781693),
    'Annapolis': LatLng(38.978764, -76.490936),
    'Boston': LatLng(42.358162, -71.063698),
    'Lansing': LatLng(42.733635, -84.555328),
    'St. Paul': LatLng(44.955097, -93.102211),
    'Jackson': LatLng(32.303848, -90.182106),
    'Jefferson City': LatLng(38.579201, -92.172935),
    'Helena': LatLng(46.585709, -112.018417),
    'Lincoln': LatLng(40.808075, -96.699654),
    'Carson City': LatLng(39.163914, -119.766121),
    'Concord': LatLng(43.206898, -71.537994),
    'Trenton': LatLng(40.220596, -74.769913),
    'Santa Fe': LatLng(35.68224, -105.939728),
    'Bismarck': LatLng(46.82085, -100.783318),
    'Albany': LatLng(42.652843, -73.757874),
    'Columbus': LatLng(39.961346, -82.999069),
    'Oklahoma City': LatLng(35.492207, -97.503342),
    'Salem': LatLng(44.938461, -123.030403),
    'Harrisburg': LatLng(40.264378, -76.883598),
    'Providence': LatLng(41.830914, -71.414963),
    'Pierre': LatLng(44.367031, -100.346405),
    'Nashville': LatLng(36.16581, -86.784241),
    'Austin': LatLng(30.27467, -97.740349),
    'Salt Lake City': LatLng(40.777477, -111.888237),
    'Montpelier': LatLng(44.262436, -72.580536),
    'Richmond': LatLng(37.538857, -77.43364),
    'Olympia': LatLng(47.035805, -122.905014),
    'Charleston': LatLng(38.336246, -81.612328),
    'Madison': LatLng(43.074684, -89.384445),
    'Cheyenne': LatLng(41.140259, -104.820236)
  };

  late final List<Marker> markers = [];

  late List<String> state = [];
  late List<int> sightings = [];

  late Marker current;
  int currentIndex = 0;

  @override
  void initState() {
    int index = 1;
    usState.forEach((key, value) {
      markers.add(Marker(
        point: value,
        builder: (context) => InkWell(
          onTap: () => _showBottomSheet(context, key),
          child: SvgPicture.asset(
            "assets/icons/pin pieno.svg",
            color: key.length < 9
                ? kColor1
                : key.length < 13
                    ? kColor2
                    : kColor3,
          ),
        ),
      ));

      sightings.add((1.2 * index).toInt());
      index++;
    });
    state = usState.keys.toList();

    super.initState();
  }

  _initialization() async {
    List<model.Marker> m = await RemoteService().getMarker();

    for (model.Marker element in m) {
      usState.putIfAbsent(
        element.state,
        () => LatLng(element.latitude, element.longitude),
      );
      markers.add(Marker(
        point: LatLng(element.latitude, element.longitude),
        builder: (context) => InkWell(
          onTap: () => _showBottomSheet(context, element.state),
          child: SvgPicture.asset(
            "assets/icons/pin pieno.svg",
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        screenSize: MediaQuery.of(context).size,
        minZoom: 3.5,
        center: currentLatLng,
        zoom: 5.5,
      ),
      nonRotatedChildren: [
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
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.zero,
                  onPressed: () => showDialog(
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
                      liveLocation();
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
    current = Marker(
        point: LatLng(position.latitude, position.longitude),
        builder: (BuildContext context) {
          return InkWell(
            onTap: () => showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (context) => Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          height: 150,
                          color: Colors.red,
                          width: double.infinity,
                        )
                      ],
                    )),
            child: SvgPicture.asset(
              "assets/icons/pin pieno.svg",
            ),
          );
        });
    markers.add(current);
    setState(() {
      _liveUpdate = !_liveUpdate;
    });
    return position;
  }

  void liveLocation() {
    LocationSettings settings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: settings).listen((position) {
      setState(() {
        currentLatLng = LatLng(position.latitude, position.longitude);
      });
    });
    // setState(() {});
  }

  void _showBottomSheet(BuildContext context, String key) {
    int index = state.indexOf(key);
    showBottomSheet(
        backgroundColor: const Color.fromARGB(150, 158, 158, 158),
        context: context,
        builder: (ctx) {
          return BottomSheet(usState: usState, item: index, sightings: index);
        });
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({
    super.key,
    required this.usState,
    required this.item,
    required this.sightings,
  });

  final Map<String, LatLng> usState;
  final int item;
  final int sightings;

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
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
          itemCount: widget.usState.length,
          options: CarouselOptions(
              initialPage: widget.item,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enlargeFactor: 0.45,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index % widget.usState.length;
                  //print(currentIndex);
                });
              },
              aspectRatio: 1.6,
              enlargeCenterPage: true,
              viewportFraction: 0.52),
          itemBuilder: (context, index, realIdx) {
            return InkWell(
              onTap: () {
                // currentLatLng = LatLng(0, 0);
                // setState(() {});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(
                    minWidth: 150,
                  ),
                  decoration: BoxDecoration(
                      color: currentIndex == index ? kColor1 : kColor2,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.usState.keys.toList()[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: getProportionateScreenWidth(14)),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Bob has\nbeen heard",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${widget.sightings}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(40),
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Text(
                            "times",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenWidth(12)),
                          ),
                        ],
                      ),
                    ],
                  ),
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
