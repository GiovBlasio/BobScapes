import 'dart:convert';

List<Audio> audioFromJson(String str) =>
    List<Audio>.from(json.decode(str).map((x) => Audio.fromJson(x)));

String audioToJson(List<Audio> data) =>
    json.encode(List.from(data.map((x) => x.toJson())));

class Audio {
  Audio({
    required this.time,
    required this.title,
    required this.path,
    required this.pathImage,
  });

  final String time;
  final String title;
  final String path;
  final String pathImage;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        time: json["time"],
        title: json["title"],
        path: json["path"],
        pathImage: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
      };
}
