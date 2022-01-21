import 'dart:convert';

import 'package:http/http.dart' as http;

class Repo {

  String apiURL = 'https://url-shortener-nu.herokuapp.com/api/alias';

  Future<http.Response> shrinkURl(String _url) async {
    final response = await http.post(
      Uri.parse(apiURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'url': _url,
      }),
    );
    return response;
  }

  Future<http.Response> getShortURl(String id) async {
    final response = await http.get(
      Uri.parse(apiURL + '/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    return response;
  }

}//