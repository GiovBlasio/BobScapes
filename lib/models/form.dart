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
  final String latitude;
  final String longitude;
  final String date;
  final String physicallySee;
  final String releasedLocation;
  final String whatSee;
  final String manyBirds;
  final String manyMale;
  final String manyFemale;
  final String manyYoung;
  final String manyBroods;
  final String moreInformation;
  final String learnMore;
  String email;
  String comment;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        time: json["time"],
        title: json["title"],
        name: json[""], latitude: json[""],
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
        // state: json["stato_compilazione"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "title": title,
      };
}
