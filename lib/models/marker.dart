import 'dart:convert';

List<Marker> markerFromJson(String str) =>
    List<Marker>.from(json.decode(str).map((x) => Marker.fromJson(x)));

String markerToJson(List<Marker> data) =>
    json.encode(List.from(data.map((x) => x.toJson())));

class Marker {
  Marker({
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.sightings,
    //  required this.state,
  });

  final double latitude;
  final double longitude;
  final String state;
  final int sightings;

  //final String state;

  factory Marker.fromJson(Map<String, dynamic> json) => Marker(
        state: json["time"],
        longitude: json["title"],
        latitude: json["title"],
        sightings: json["title"],
        // state: json["stato_compilazione"],
      );

  Map<String, dynamic> toJson() => {
        "time": longitude,
        "title": latitude,
        "state": state,
        //   "stato_compilazione": state,
      };
}
