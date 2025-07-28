import 'dart:convert';

List<Form> formFromJson(String str) =>
    List<Form>.from(json.decode(str).map((x) => Form.fromJson(x)));

String formToJson(List<Form> data) =>
    json.encode(List.from(data.map((x) => x.toJson())));

class Form {
  Form({
    required this.name,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.time,
    required this.physicallySee,
    required this.releasedLocation,
    required this.whatSee,
    required this.manyBirds,
    required this.manyMale,
    required this.manyFemale,
    required this.manyYoung,
    required this.manyBroods,
    required this.moreInformation,
    required this.learnMore,
    this.email = '',
    this.comment = '',
  });

  final String time;
  final String title;
  final String name;
  final double latitude;
  final double longitude;
  final String date;
  final String physicallySee;
  final String releasedLocation;
  final String whatSee;
  final int manyBirds;
  final int manyMale;
  final int manyFemale;
  final int manyYoung;
  final int manyBroods;
  final String moreInformation;
  final String learnMore;
  String email;
  String comment;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        time: json["time"],
        title: json["title"],
        name: json[""],
        latitude: json[""],
        longitude: json[""],
        date: json[""],
        physicallySee: json[""],
        releasedLocation: json[""],
        whatSee: json[""],
        manyBirds: json[""],
        manyMale: json[""],
        manyFemale: json[""],
        manyYoung: json[""],
        manyBroods: json[""],
        moreInformation: json[""],
        learnMore: json[""],
        email: json[""],
        comment: json[""],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "date": date,
        "physicallySee": physicallySee,
        "releasedLocation": releasedLocation,
        "whatSee": whatSee,
        "manyBirds": manyBirds,
        "manyMale": manyMale,
        "manyFemale": manyFemale,
        "manyYoung": manyYoung,
        "manyBroods": manyBroods,
        "moreInformation": moreInformation,
        "learnMore": learnMore,
        "email": email,
        "comment": comment,
      };
}
