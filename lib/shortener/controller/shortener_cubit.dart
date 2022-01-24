import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shortmyurl/herokuapp_repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/data/links_db.dart' as database;
import 'package:shortmyurl/shortener/controller/shortener_state.dart';

class ShortenerCubit extends Cubit<ShortenerState> {
  ShortenerCubit() : super(const InitialState());

  final HerokuAppRepo _repo = HerokuAppRepo();

  Future<void> shrinkUrl(String urlToShrink) async {
    emit(const LoadingState());
    try {
      final bool repeated = await checkRepeated(urlToShrink);
      if (!repeated) {
        final Map<String, String> linkToSubmit = <String, String>{
          'url': urlToShrink,
        };
        final response = await _repo.postToURl(linkToSubmit);
        if (response.statusCode == 201 || response.statusCode == 200) {
          final Map responseMap =
              jsonDecode(utf8.decode(response.bodyBytes)) as Map;
          final Map<String, String> newLink = {
            'original_link': responseMap['_links']['self'].toString(),
            'short': responseMap['_links']['short'].toString(),
            'alias': responseMap['alias'].toString(),
          };
          if (kDebugMode) {
            print('Shrink Link: ${newLink.toString()}');
          }
          database.links.add(newLink);
          emit(ShortenedState(newLink));
        } else {
          emit(ErrorState('Invalid response from shortener'));
        }
      } else {
        emit(ErrorState('Url already shrank before'));
      }
    } catch (e) {
      emit(ErrorState('Shrink error: ${e.toString()}'));
    }
  } //

  Future<void> getShortURl(String alias) async {
    emit(const LoadingState());
    try {
      final response = await _repo.getFromURl(alias);
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map responseMap =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        final Map<String, String> fullLink = {
          'full_link': responseMap['url'].toString(),
          'alias': alias,
        };
        if (kDebugMode) {
          print('Full Link from alias: ${fullLink.toString()}');
        }
        emit(RetrievedState(fullLink));
      } else {
        emit(ErrorState('Invalid response from retriever'));
      }
    } catch (e) {
      emit(ErrorState('Retriever error: ${e.toString()}'));
    }
  } //

  Future<bool> checkRepeated(String urlToShrink) async {
    bool repeated = false;
    for (var element in database.links) {
      if (element['original_link'] == urlToShrink) {
        repeated = true;
      }
    }
    return repeated;
  } //

} //
