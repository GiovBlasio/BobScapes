import 'dart:convert';
import 'dart:io';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/models/audio.dart';
import 'package:bobscapes/models/marker.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var client = http.Client();
  static const String bearerAuth = 'Bearer prova';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // HttpHeaders.authorizationHeader: bearerAuth,
  };

  // Future<List<Audio>> getAudio(
  //     // String userSignature,
  //     [
  //   String url =
  //       'https://odoo14-cefpas.unitivastaging.it/api/v1/richiesta-forms',
  // ]) async {
  //   return await Future.delayed(
  //       const Duration(seconds: 1),
  //       () => [
  //             Audio(
  //                 time: "3:24",
  //                 title: "Male Bobwhite Spring Call",
  //                 path: "",
  //                 pathImage: ""),
  //             Audio(
  //                 time: "3:10",
  //                 title: "Fall covey Call",
  //                 path: "",
  //                 pathImage: "")
  //           ]);
  //   // Map<String, dynamic> param = {
  //   //   "params": {"user_signature": userSignature}
  //   // };

  //   // Uri uri = Uri.parse(url);

  //   // http.Response response =
  //   //     await client.post(uri, headers: headers, body: json.encode(param));

  //   // if (response.statusCode == 200) {
  //   //   var json = response.body;

  //   //   var map = jsonDecode(json);

  //   //   return audioFromJson(jsonEncode(map['result']['user_forms']));
  //   // } else {
  //   //   throw Exception(response.statusCode);
  //   // }
  // }

  Future<List<Marker>> getMarker([
    Map? params,
    String url =
        'https://odoo14-cefpas.unitivastaging.it/api/v1/richiesta-forms',
  ]) async {

    //TODO da togliere 
    int index = 0;
    Map<String, Marker> map = state.map((key, value) {
      index++;
      return MapEntry<String, Marker>(
          key,
          Marker(
              latitude: value.latitude,
              longitude: value.longitude,
              state: key,
              sightings: index));
    });

    return await Future.delayed(
        const Duration(seconds: 1), () => map.values.toList());

    Uri uri = Uri.parse(url);

    http.Response response =
        await client.post(uri, headers: headers, body: json.encode(params));

    if (response.statusCode == 200) {
      var json = response.body;

      var map = jsonDecode(json);

      return markerFromJson(jsonEncode(map));

      // return markerFromJson(jsonEncode(map['result']['user_forms']));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> sendData(
    Map params, [
    String url =
        'https://5kxsouk1xj.execute-api.us-east-1.amazonaws.com/default/bobwhite-app-add-sighting',
  ]) async {
     return await Future.delayed(const Duration(seconds: 2), () => true);

   // Uri uri = Uri.parse(url);

   // http.Response response =
     //   await client.post(uri, headers: headers, body: json.encode(params));

    // if (response.statusCode == 200) {
    //   var json = response.body;

    //   print(response.body);

    //   var map = jsonDecode(json);
    //   if (map['result'] == "ok") {
    //     return true;
    //   } else {
    //     return false;
    //    // throw Exception(map['result']['message']);
    //   }
    // }
    // return false;
  }
}
