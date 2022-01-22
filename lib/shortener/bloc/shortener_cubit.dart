import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shortmyurl/herokuapp_repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shortmyurl/shortener/model/shortener_model.dart';

class ShortenerCubit extends Cubit<ShortenerState> {
  ShortenerCubit() : super(const InitialState());

  final HerokuAppRepo _repo = HerokuAppRepo();

  Future<void> shrinkUrl(String urlToShrink) async {
    emit(const LoadingState());
    try {
      final Map<String, String> linkToSubmit = <String, String>{
        'url': urlToShrink,
      };
      final response = await _repo.postToURl(linkToSubmit);
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map responseMap = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        final Map<String, String> newLink = {
          'long': responseMap['_links']['self'].toString(),
          'short': responseMap['_links']['short'].toString(),
          'id': responseMap['alias'].toString(),
        };
        if (kDebugMode) {
          print('Link: ${newLink.toString()}');
        }
        emit(ShortenedState(newLink));
      } else {
        emit(ErrorState('Invalid response'));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }//

  Future<void> getShortURl(String urlId) async {
    final response = await _repo.getFromURl(urlId);
    /*
    if (response.statusCode == 201 || response.statusCode == 200) {
      final values = json.decode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }*/
    if (kDebugMode) {
      print(response.body.toString());
      print(response.statusCode.toString());
    }
  }//

}//