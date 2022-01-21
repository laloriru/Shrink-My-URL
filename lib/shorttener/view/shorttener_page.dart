import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shorttener/bloc/shortener_cubit.dart';

class ShorttenerPage extends StatefulWidget {
  const ShorttenerPage({Key? key}) : super(key: key);

  @override
  State<ShorttenerPage> createState() => _ShorttenerPageState();
}

class _ShorttenerPageState extends State<ShorttenerPage> {

  @override
  void initState() {
    //BlocProvider.of<ShorttenerCubit>(context).shrinkUrl('hola.com.x');
    BlocProvider.of<ShorttenerCubit>(context).getShortURl('54885');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Shorttener from Heroku'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    bottomSheet: Text('Hello'),
    );
  }
}