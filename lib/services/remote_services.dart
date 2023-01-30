import 'dart:convert';
import 'dart:io';

import 'package:bobscapes/models/audio.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  var client = http.Client();
  static const String bearerAuth =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoX2p3dF9jZWZwYXNfc3VydmV5c19zZXJ2aWNlcyIsImlzcyI6ImNlZnBhcyBzdXJ2ZXlzIGlzc3VlciIsImV4cCI6NDY0Mjc4NDcwOS44NzY1NzV9.sDQXEnT096cNpCxTvLc1m269P4e7KtZM5uAwxCMjBR8';
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: bearerAuth,
  };

  Future<List<Audio>> getAudio(
    String userSignature, [
    String url =
        'https://odoo14-cefpas.unitivastaging.it/api/v1/richiesta-forms',
  ]) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Audio(time: "3:24", title: "Male Bobwhite Spring Call"),
              Audio(time: "3:10", title: "Fall covey Call")
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

  Future<void> sendData(
      //   Map params, [
      //   String url =
      //       'https://odoo14-cefpas.unitivastaging.it/api/v1/compilazione-questionario',]
      ) async {
    return await Future.delayed(const Duration(seconds: 2), () => {});
    //   Uri uri = Uri.parse(url);

    //   ///
    //   /// Richiesta POST
    //   ///
    //   http.Response response =
    //       await client.post(uri, headers: headers, body: json.encode(params));

    //   ///
    //   /// Se la richiesta non è andata a buon fine si lancia un'eccezione
    //   ///
    //   if (response.statusCode == 200) {
    //     ///
    //     /// Stringa relativa alla risposta ottenuta dalla richiesta POST appena inviata
    //     ///
    //     var json = response.body;

    //     ///
    //     /// Decodifica della stringa ricevuta, in modo da poter leggere lo stato della richiesta
    //     ///
    //     var map = jsonDecode(json);
    //     if (map['result']['status'] == 200) {
    //     } else {
    //       throw Exception(map['result']['message']);
    //     }
    //   }
  }
}
