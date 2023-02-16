import 'package:bobscapes/constants.dart';
import 'package:bobscapes/services/remote_services.dart';
import 'package:bobscapes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:latlong2/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bobscapes/models/marker.dart' as model;

import 'custom_carousel.dart';

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
          bottom: getProportionateScreenHeight(85),
          right: getProportionateScreenWidth(10),
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //     iconSize: getProportionateScreenHeight(25),
              //     alignment: Alignment.bottomCenter,
              //     padding: EdgeInsets.zero,
              //     onPressed: () => showDialog(
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
                width: getProportionateScreenWidth(41),
                height: getProportionateScreenHeight(41),
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
            "assets/icons/icon-pointer.svg",
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
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
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
        backgroundColor: const Color.fromARGB(150, 158, 158, 158),
        context: context,
        builder: (ctx) {
          return BottomSheetCards(
              state: state, item: index, sightings: sightings);
        });
  }

  _showDisclaimer(BuildContext context) {
    return Stack(children: [
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: 0,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Positioned(
              bottom: 400,
              left: 25,
              child: Image.asset(
                "assets/images/quail-reflected.png",
                height: 200,
              ),
            ),
            Positioned(
              height: 453,
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
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(30),
                                right: getProportionateScreenWidth(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 30,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: Text(
                                "The exact location of your sightings will not be shared with the public.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        getProportionateScreenWidth(14.5)),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(30),
                                  top: 20,
                                  bottom: 5,
                                  right: getProportionateScreenWidth(40)),
                              child: const Text(
                                "Any personal sighting information you share will only be used internally to inform management recommendations with conservation partners such as Quail Forever, USDA’s NRCS, and University of Georgia Martin Game Lab.",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.5),
                              )),
                        ],
                      ),
                    )),
              ),
            ),
          ]))
    ]);
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
  late final PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.item;
    pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.47,
    );
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

        LimitedBox(
          maxHeight: 230,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              currentIndex = index % widget.state.length;
              setState(() {});
            },
            itemBuilder: (_, index) {
              return AnimatedBuilder(
                  animation: pageController,
                  builder: (ctx, child) {
                    return child!;
                  },
                  child: UnconstrainedBox(
                    child: Column(
                      children: [
                        AnimatedContainer(
                          //  color: Colors.red,
                          duration: Duration(milliseconds: 750),
                          height: currentIndex == index % widget.state.length
                              ? 0
                              : 60,
                        ),
                        AnimatedContainer(
                          //  color: Colors.red,
                          duration: Duration(milliseconds: 750),
                          height: currentIndex == index % widget.state.length
                              ? 230
                              : 170,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: EdgeInsets.symmetric(horizontal: 20),

                              //  constraints: const BoxConstraints(
                              //    //minWidth: 120,
                              //    maxHeight: 150
                              //  ),
                              decoration: BoxDecoration(
                                  color: currentIndex ==
                                          index % widget.state.length
                                      ? kColor3
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.state[index % widget.state.length],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: kTextColor,
                                        fontSize:
                                            getProportionateScreenWidth(14)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Bob has\nbeen heard",
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        color: kTextColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    mainAxisSize: MainAxisSize.min,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      40),
                                              color: kTextColor,
                                              fontWeight: FontWeight.w400),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${widget.sightings[index % widget.state.length]}",
                                            ),
                                            if (widget.sightings[index %
                                                        widget.state.length]
                                                    .toString()
                                                    .length ==
                                                1)
                                              const TextSpan(
                                                text: '0',
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(45),
                                      ),
                                      Text(
                                        "times",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor,
                                            fontSize:
                                                getProportionateScreenWidth(
                                                    12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            itemCount: widget.state.length,
          ),

          // : AnimatedContainer(
          //   duration: Duration(seconds: 1),
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   width: 140,
          //   height: 0 == index ? 200 : 100,
          //   color: Colors.red,
          // ),
        ),

        // AnimatedContainer(
        //   duration: Duration(seconds: 1),
        //   height: currentIndex == 3 % widget.state.length ? 200:100,
        //   child: PageView.builder(
        //     controller: pageController,
        //     onPageChanged: (index) {
        //       currentIndex = index % widget.state.length;
        //       setState(() {});
        //     },
        //     itemBuilder: (_, index) {
        //       return AnimatedBuilder(
        //           animation: pageController,
        //           builder: (ctx, child) {
        //             return child!;
        //           },
        //           child: AnimatedContainer(
        //             duration: Duration(seconds: 1),
        //             height: currentIndex == index
        //                 ? 200
        //                 : 140,
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20.0),
        //               ),
        //               child: AnimatedContainer(
        //                 duration: const Duration(milliseconds: 200),
        //                 padding: const EdgeInsets.all(20),

        //                 //  constraints: const BoxConstraints(
        //                 //    //minWidth: 120,
        //                 //    maxHeight: 150
        //                 //  ),
        //                 decoration: BoxDecoration(
        //                     color: currentIndex == index % widget.state.length
        //                         ? kColor3
        //                         : Colors.white,
        //                     borderRadius: BorderRadius.circular(20)),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     Text(
        //                       widget.state[index % widget.state.length],
        //                       style: TextStyle(
        //                           fontWeight: FontWeight.w700,
        //                           color: kTextColor,
        //                           fontSize: getProportionateScreenWidth(14)),
        //                     ),
        //                     const Spacer(),
        //                     Text(
        //                       "Bob has\nbeen heard",
        //                       style: TextStyle(
        //                           fontSize: getProportionateScreenWidth(12),
        //                           color: kTextColor,
        //                           fontWeight: FontWeight.w400),
        //                     ),
        //                     Row(
        //                       crossAxisAlignment: CrossAxisAlignment.baseline,
        //                       mainAxisSize: MainAxisSize.min,
        //                       textBaseline: TextBaseline.alphabetic,
        //                       children: [
        //                         Text(
        //                           "${widget.sightings[index % widget.state.length]}",
        //                           style: TextStyle(
        //                               fontSize:
        //                                   getProportionateScreenWidth(40),
        //                               color: kTextColor,
        //                               fontWeight: FontWeight.w400),
        //                         ),
        //                         SizedBox(
        //                           width: getProportionateScreenWidth(45),
        //                         ),
        //                         Text(
        //                           "times",
        //                           style: TextStyle(
        //                               fontWeight: FontWeight.w500,
        //                               color: kTextColor,
        //                               fontSize:
        //                                   getProportionateScreenWidth(12)),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ));
        //     },
        //     //  itemCount: widget.state.length,
        //   ),
        // ),

        // SizedBox(
        //   height: getProportionateScreenHeight(280),
        //    child: Carousel()
        //    // InfiniteCarousel.builder(
        //   //   itemCount: widget.state.length,
        //   //   itemExtent: 180,
        //   //   center: false,
        //   //   anchor: 0.15,
        //   //   velocityFactor: 0.2,
        //   //   onIndexChanged: (index) {
        //   //     setState(() {
        //   //       currentIndex = index % widget.state.length;
        //   //     });
        //   //   },
        //   //   //controller: controller,
        //   //   axisDirection: Axis.horizontal,
        //   //   loop: true,
        //   //   itemBuilder: (context, index, realIndex) {
        //   //     return Card(
        //   //       shape: RoundedRectangleBorder(
        //   //         borderRadius: BorderRadius.circular(20.0),
        //   //       ),
        //   //       child: AnimatedContainer(

        //   //         duration: const Duration(milliseconds: 200),
        //   //         padding: const EdgeInsets.all(20),

        //   //         //  constraints: const BoxConstraints(
        //   //         //    //minWidth: 120,
        //   //         //    maxHeight: 150
        //   //         //  ),
        //   //         decoration: BoxDecoration(
        //   //             color: currentIndex == index ? kColor3 : Colors.white,
        //   //             borderRadius: BorderRadius.circular(20)),
        //   //         child: Column(
        //   //           crossAxisAlignment: CrossAxisAlignment.start,
        //   //           mainAxisAlignment: MainAxisAlignment.end,
        //   //           mainAxisSize: MainAxisSize.min,
        //   //           children: [
        //   //             Text(
        //   //               widget.state[index],
        //   //               style: TextStyle(
        //   //                   fontWeight: FontWeight.w700,
        //   //                   color: kTextColor,
        //   //                   fontSize: getProportionateScreenWidth(14)),
        //   //             ),
        //   //             const Spacer(),
        //   //             Text(
        //   //               "Bob has\nbeen heard",
        //   //               style: TextStyle(
        //   //                   fontSize: getProportionateScreenWidth(12),
        //   //                   color: kTextColor,
        //   //                   fontWeight: FontWeight.w400),
        //   //             ),
        //   //             Row(
        //   //               crossAxisAlignment: CrossAxisAlignment.baseline,
        //   //               mainAxisSize: MainAxisSize.min,
        //   //               textBaseline: TextBaseline.alphabetic,
        //   //               children: [
        //   //                 Text(
        //   //                   "${widget.sightings[index]}",
        //   //                   style: TextStyle(
        //   //                       fontSize: getProportionateScreenWidth(40),
        //   //                       color: kTextColor,
        //   //                       fontWeight: FontWeight.w400),
        //   //                 ),
        //   //                 SizedBox(
        //   //                   width: getProportionateScreenWidth(45),
        //   //                 ),
        //   //                 Text(
        //   //                   "times",
        //   //                   style: TextStyle(
        //   //                       fontWeight: FontWeight.w500,
        //   //                       color: kTextColor,
        //   //                       fontSize: getProportionateScreenWidth(12)),
        //   //                 ),
        //   //               ],
        //   //             ),
        //   //           ],
        //   //         ),
        //   //       ),
        //   //     );
        //   //   },
        //   // ),
        // ),
        // // CarouselSlider.builder(
        //   itemCount: widget.state.length,
        //   options: CarouselOptions(
        //       initialPage: widget.item,
        //       enlargeStrategy: CenterPageEnlargeStrategy.height,
        //       enlargeFactor: 0.45,
        //       onPageChanged: (index, reason) {
        //         setState(() {
        //           currentIndex = index % widget.state.length;
        //         });
        //       },
        //       aspectRatio: 1.8,
        //       enlargeCenterPage: true,
        //       viewportFraction: 0.52),
        //   itemBuilder: (context, index, realIdx) {
        //     return Card(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0),
        //       ),
        //       child: AnimatedContainer(
        //         duration: const Duration(milliseconds: 200),
        //         padding: const EdgeInsets.all(20),
        //         constraints: const BoxConstraints(
        //           minWidth: 120,
        //         ),
        //         decoration: BoxDecoration(
        //             color: currentIndex == index ? kColor3 : Colors.white,
        //             borderRadius: BorderRadius.circular(20)),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Text(
        //               widget.state[index],
        //               style: TextStyle(
        //                   fontWeight: FontWeight.w700,
        //                   color: kTextColor,
        //                   fontSize: getProportionateScreenWidth(14)),
        //             ),
        //             const Spacer(
        //               flex: 1,
        //             ),
        //             Text(
        //               "Bob has\nbeen heard",
        //               style: TextStyle(
        //                   fontSize: getProportionateScreenWidth(12),
        //                   color: kTextColor,
        //                   fontWeight: FontWeight.w400),
        //             ),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.baseline,
        //               mainAxisSize: MainAxisSize.min,
        //               textBaseline: TextBaseline.alphabetic,
        //               children: [
        //                 Text(
        //                   "${widget.sightings[index]}",
        //                   style: TextStyle(
        //                       fontSize: getProportionateScreenWidth(40),
        //                       color: kTextColor,
        //                       fontWeight: FontWeight.w400),
        //                 ),
        //                 SizedBox(
        //                   width: getProportionateScreenWidth(45),
        //                 ),
        //                 Text(
        //                   "times",
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.w500,
        //                       color: kTextColor,
        //                       fontSize: getProportionateScreenWidth(12)),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        SizedBox(
          height: getProportionateScreenHeight(18),
        )
      ],
    );
  }

  AnimatedContainer _buildCard({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      //margin: const EdgeInsets.only(right: 8),
      height: currentIndex == index ? 200 : 100,
      width: currentIndex == index
          ? getProportionateScreenWidth(130)
          : getProportionateScreenWidth(130),
      decoration: BoxDecoration(
          color: currentIndex == index ? kColor3 : kColor3,
          shape: BoxShape.rectangle),
    );
  }
}
