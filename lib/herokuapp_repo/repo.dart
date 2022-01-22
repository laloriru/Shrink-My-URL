import 'dart:convert';

import 'package:http/http.dart' as http;

class HerokuAppRepo {

  String apiURL = 'https://url-shortener-nu.herokuapp.com/api/alias';

  Future<http.Response> postToURl(Map<String, String> _body) async {
    final response = await http.post(
      Uri.parse(apiURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_body),
    );
    return response;
  }

  Future<http.Response> getFromURl(String id) async {
    final response = await http.get(
      Uri.parse(apiURL + '/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    return response;
  }

}//