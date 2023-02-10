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
  });

  final double latitude;
  final double longitude;
  final String state;
  final int sightings;

  factory Marker.fromJson(Map<String, dynamic> json) => Marker(
        state: json["state"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        sightings: json["sightings"],
      );

  Map<String, dynamic> toJson() => {
        "time": longitude,
        "title": latitude,
        "state": state,
        //   "stato_compilazione": state,
      };
}
