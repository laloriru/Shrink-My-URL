import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/bloc/shortener_cubit.dart';

class ShortenerLinkList {
  List<Map<String, dynamic>> items = <Map<String, dynamic>>[];
  int itemsCounter = 0;

  Future<List<Map>> getLinks() async {
    itemsCounter = items.length;
    return items;
  } //

  Widget list() {
    return Expanded(
        child: FutureBuilder(
            future: getLinks(),
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
                      return Text(item[index]['link']);
                    });
              } else {
                return Container();
              }
            }));
  } //

} //
