import 'dart:convert';

import 'package:shortmyurl/repository/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/url_model.dart';

class ShorttenerCubit extends Cubit<UrlState> {
  ShorttenerCubit() : super(const InitialState());

  final Repo _repo = Repo();

  Future<void> shrinkUrl(String urlToShrink) async {
    final response = await _repo.shrinkURl(urlToShrink);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final values = json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
    print(response.body.toString());
    print(response.statusCode.toString());
  }

  Future<void> getShortURl(String id) async {
    final response = await _repo.getShortURl(id);
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