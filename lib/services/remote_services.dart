import 'dart:convert';
import 'dart:io';

import 'package:bobscapes/constants.dart';
import 'package:bobscapes/models/audio.dart';
import 'package:bobscapes/models/marker.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RemoteService {
  var client = http.Client();
  static const String bearerAuth =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoX2p3dF9jZWZwYXNfc3VydmV5c19zZXJ2aWNlcyIsImlzcyI6ImNlZnBhcyBzdXJ2ZXlzIGlzc3VlciIsImV4cCI6NDY0Mjc4NDcwOS44NzY1NzV9.sDQXEnT096cNpCxTvLc1m269P4e7KtZM5uAwxCMjBR8';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: bearerAuth,
  };

  Future<List<Audio>> getAudio(
      // String userSignature,
      [
    String url =
        'https://odoo14-cefpas.unitivastaging.it/api/v1/richiesta-forms',
  ]) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Audio(
                time: "3:24",
                title: "Male Bobwhite Spring Call",
              ),
              Audio(
                time: "3:10",
                title: "Fall covey Call",
              )
            ]);
    // Map<String, dynamic> param = {
    //   "params": {"user_signature": userSignature}
    // };

    // Uri uri = Uri.parse(url);

    // http.Response response =
    //     await client.post(uri, headers: headers, body: json.encode(param));

    // if (response.statusCode == 200) {
    //   var json = response.body;

    //   var map = jsonDecode(json);

    //   return audioFromJson(jsonEncode(map['result']['user_forms']));
    // } else {
    //   throw Exception(response.statusCode);
    // }
  }

  Future<List<Marker>> getMarker([
    String url =
        'https://odoo14-cefpas.unitivastaging.it/api/v1/richiesta-forms',
  ]) async {
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

    // Map<String, dynamic> param = {
    //   "params": {"user_signature": userSignature}
    // };

    // Uri uri = Uri.parse(url);

    // http.Response response =
    //     await client.post(uri, headers: headers, body: json.encode(param));

    // if (response.statusCode == 200) {
    //   var json = response.body;

    //   var map = jsonDecode(json);

    //   return markerFromJson(jsonEncode(map['result']['user_forms']));
    // } else {
    //   throw Exception(response.statusCode);
    // }
  }

  Future<void> sendData(
      //   Map params, [
      //   String url =
      //       'https://odoo14-cefpas.unitivastaging.it/api/v1/compilazione-questionario',]
      ) async {
    return await Future.delayed(const Duration(seconds: 2), () => {});
    //   Uri uri = Uri.parse(url);

    //   http.Response response =
    //       await client.post(uri, headers: headers, body: json.encode(params));

    //   if (response.statusCode == 200) {
   
    //     var json = response.body;

    //     var map = jsonDecode(json);
    //     if (map['result']['status'] == 200) {
    //     } else {
    //       throw Exception(map['result']['message']);
    //     }
    //   }
  }
}
