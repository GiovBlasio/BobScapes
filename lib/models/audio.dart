import 'dart:convert';

List<Audio> audioFromJson(String str) =>
    List<Audio>.from(json.decode(str).map((x) => Audio.fromJson(x)));

String audioToJson(List<Audio> data) =>
    json.encode(List.from(data.map((x) => x.toJson())));

class Audio {
  Audio({
    required this.time,
    required this.title,
    //  required this.state,
  });

  final String time;
  final String title;
  //final String state;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        time: json["time"],
        title: json["title"],
        // state: json["stato_compilazione"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        //   "stato_compilazione": state,
      };
}
