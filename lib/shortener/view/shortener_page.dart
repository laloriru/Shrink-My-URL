import 'package:flutter/material.dart';
import 'form.dart';
import 'list.dart';

class ShortenerPage extends StatefulWidget {
  const ShortenerPage({Key? key}) : super(key: key);

  @override
  State<ShortenerPage> createState() => _ShortenerPageState();
}

class _ShortenerPageState extends State<ShortenerPage> {
  @override
  void initState() {
    //BlocProvider.of<ShorttenerCubit>(context).shrinkUrl('hola.com.x');
    //BlocProvider.of<ShorttenerCubit>(context).getShortURl('54885');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        primary: true,
        centerTitle: true,
        title: const Text('Url Shorttener from Heroku'),
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ShortenerForm(context).form(),
            ShortenerLinkList().list(),
          ]),
    );
  } //





} //_ShortenerPageState
