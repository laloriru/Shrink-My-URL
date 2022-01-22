import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/bloc/shortener_cubit.dart';

class ShortenerLinkList {
  ShortenerLinkList({this.linkToAdd}) : super();

  Map<String, String>? linkToAdd = <String, String>{};
  int itemsCounter = 0;

  Future<List<Map>> buildLinksList() async {
    final List<Map<String, String>> links = <Map<String, String>>[];
    if (linkToAdd?.isNotEmpty == true){
      links.add(linkToAdd!);
    }
    itemsCounter = links.length;
    return links;
  } //

  Widget list() {
    return FutureBuilder(
        future: buildLinksList(),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('.....');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: itemsCounter,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final List<Map<dynamic, dynamic>> item =
                      snapshot.data! as List<Map<dynamic, dynamic>>;
                  return Text(item[index]['short']);
                });
          } else {
            return Container();
          }
        });
  } //

} //
