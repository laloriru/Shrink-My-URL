import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HerokuAppRepo {
  String apiURL = 'https://url-shortener-nu.herokuapp.com/api/alias';

  Future<http.Response> postToURl(Map<String, String> _body) async {
    final response = await http
        .post(
          Uri.parse(apiURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(_body),
        )
        .timeout(const Duration(seconds: 5));
    if (kDebugMode) {
      print('postToURl Response Body: ${response.body.toString()}');
    }
    return response;
  }

  Future<http.Response> getFromURl(String alias) async {
    final response =
        await http.get(Uri.parse(apiURL + '/$alias'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).timeout(const Duration(seconds: 5));
    if (kDebugMode) {
      print('getFromURl Response Body: ${response.body.toString()}');
    }
    return response;
  }
} //
