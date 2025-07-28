import 'dart:convert';
import 'dart:io';

import '../models/marker.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var client = http.Client();
  static const String bearerAuth = 'Bearer prova';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // HttpHeaders.authorizationHeader: bearerAuth,
    "x-api-key": "C0ZOsvnQxv3VeAp1YGXoWaEDywtPurYU6suLwNWs",
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
        'https://5kxsouk1xj.execute-api.us-east-1.amazonaws.com/default/bobwhite-app-map-sighting',
  ]) async {
    Uri uri = Uri.parse(url);

    http.Response response = await client.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var json = response.body;

      var map = jsonDecode(json);

      print(map['marker']);

      return markerFromJson(jsonEncode(map['marker']));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<bool> sendData(
    Map params, [
    String url =
        'https://5kxsouk1xj.execute-api.us-east-1.amazonaws.com/default/bobwhite-app-add-sighting',
  ]) async {
    // return await Future.delayed(const Duration(seconds: 2), () => true);

    Uri uri = Uri.parse(url);

    http.Response response =
        await client.post(uri, headers: headers, body: json.encode(params));

    print(params);

    if (response.statusCode == 200) {
      var json = response.body;

      var map = jsonDecode(json);
      if (map['result'] == "ok") {
        return true;
      } else {
        return false;
        // throw Exception(map['result']['message']);
      }
    }
    return false;
  }
}
