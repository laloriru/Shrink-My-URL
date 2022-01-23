import 'package:flutter/material.dart';
import 'package:shortmyurl/shortener/data/links_db.dart' as database;
import 'package:clipboard/clipboard.dart';

class ShortenerLinkList {
  ShortenerLinkList({required this.context, this.linkToAdd}) : super();

  BuildContext context;
  Map<String, String>? linkToAdd = <String, String>{};
  int itemsCounter = 0;

  Future<List<Map>> buildLinksList() async {
    if (linkToAdd?.isNotEmpty == true) {
      database.links.add(linkToAdd!);
    }
    itemsCounter = database.links.length;
    return database.links;
  } //

  copyToClipboard(String _copy) {
    FlutterClipboard.copy(_copy).then((value) {
      const SnackBar _snackBar = SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30.0),
          content: Text(
            '¡Short URL copied to clipboard!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      });
    });
  } //

  Widget list() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child:
                  Center(child: Text('Tap to copy shrank link to clipboard'))),
          FutureBuilder(
              future: buildLinksList(),
              builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<Map<String, String>> item =
                      snapshot.data! as List<Map<String, String>>;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: itemsCounter,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => copyToClipboard(
                                item[index]['short'].toString()),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 3, 8, 8),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: ListTile(
                                        title: Text(
                                            item[index]['short'].toString()),
                                        subtitle: Text(
                                            item[index]['long'].toString())))));
                      });
                } else {
                  return Container();
                }
              })
        ]);
  } //

} //
