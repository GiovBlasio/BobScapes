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

  static String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  factory Marker.fromJson(Map<String, dynamic> json) {
    String stato = json["state"] as String;
    stato = stato.replaceAll('_', ' ');
    stato = capitalizeAllWord(stato);
    return Marker(
      state: stato,
      longitude: json["longitude"] ?? 0,
      latitude: json["latitude"] ?? 0,
      sightings: json["sightings"],
    );
  }

  Map<String, dynamic> toJson() => {
        "time": longitude,
        "title": latitude,
        "state": state,
        //   "stato_compilazione": state,
      };
}
