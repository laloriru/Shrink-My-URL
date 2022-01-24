import 'package:flutter/material.dart';
import 'package:shortmyurl/shortener/data/links_db.dart' as database;
import 'package:clipboard/clipboard.dart';
import 'package:shortmyurl/snackbar.dart';
import 'package:shortmyurl/shortener/controller/shortener_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShortenerLinkList extends StatelessWidget {
  ShortenerLinkList({Key? key}) : super(key: key);

  int itemsCounter = 0;

  @override
  Widget build(BuildContext context) {
    Future<List<Map>> buildLinksList() async {
      itemsCounter = database.links.length;
      return database.links;
    } //

    Future<void> retrieveUrlFromAlias(String alias) async {
      BlocProvider.of<ShortenerCubit>(context).getShortURl(alias);
    } //

    void copyToClipboard(String _copy) {
      FlutterClipboard.copy(_copy).then((value) {
        CustomSnackbar(context).show(
            '¡Short URL copied to clipboard!', Colors.brown, Colors.white);
      });
    } //

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (database.links.isNotEmpty) ? header() : Container(),
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
                            onTap: () => retrieveUrlFromAlias(
                                item[index]['alias'].toString()),
                            onDoubleTap: () => copyToClipboard(
                                item[index]['short'].toString()),
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 3, 12, 7),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: ListTile(
                                        title: Text(
                                            item[index]['short'].toString()),
                                        subtitle: Text(item[index]
                                                ['original_link']
                                            .toString())))));
                      });
                } else {
                  return Container();
                }
              })
        ]);
  } //

  Widget header() {
    return Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 25),
            child: Icon(Icons.cloud_download, color: Colors.green)),
        SizedBox(width: 5),
        Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text('Tap to retrieve link from alias')),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: const <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Icon(Icons.content_copy, color: Colors.blueGrey)),
        SizedBox(width: 5),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Tap to retrieve link from alias')),
      ])
    ]);
  } //

} //
