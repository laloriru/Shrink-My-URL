import 'dart:convert';

import 'package:shortmyurl/herokuapp_repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/url_model.dart';

class ShortenerCubit extends Cubit<UrlState> {
  ShortenerCubit() : super(const InitialState());

  final HerokuAppRepo _repo = HerokuAppRepo();

  Future<void> shrinkUrl(String urlToShrink) async {
    final Map<String, String> _post = <String, String>{
      'url': urlToShrink,
    };
    final response = await _repo.postToURl(_post);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final values = json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
    print(response.body.toString());
    print(response.statusCode.toString());
  }

  Future<void> getShortURl(String urlId) async {
    final response = await _repo.getFromURl(urlId);
    /*
    if (response.statusCode == 201 || response.statusCode == 200) {
      final values = json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }*/
    print(response.body.toString());
    print(response.statusCode.toString());
  }

}//