import 'package:flutter/material.dart';
import 'package:shortmyurl/shortener/model/shortener_model.dart';
import 'package:shortmyurl/shortener/view/form.dart';
import 'package:shortmyurl/shortener/view/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/bloc/shortener_cubit.dart';

class ShortenerPage extends StatefulWidget {
  const ShortenerPage({Key? key}) : super(key: key);

  @override
  State<ShortenerPage> createState() => _ShortenerPageState();
}

class _ShortenerPageState extends State<ShortenerPage> {
  @override
  void initState() {
    //BlocProvider.of<ShortenerCubit>(context).shrinkUrl('hola.com.x');
    //BlocProvider.of<ShortenerCubit>(context).getShortURl('54885');
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
      body: blocBuilder(),
    );
  } //

  Widget blocBuilder() {
    return BlocBuilder<ShortenerCubit, ShortenerState>(
        builder: (BuildContext context, ShortenerState? state) {
      if (state is InitialState) {
        return ShortenerForm(context).form();
      } else if (state is LoadingState) {
        return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 40.0,
              width: 40.0,
            ));
      } else if (state is ShortenedState) {
        return ListView(children: <Widget>[
          ShortenerForm(context).form(),
          ShortenerLinkList(linkToAdd: state.link).list(),
        ]);
      } else {
        return const Center(child: Text('Please verify internet connection.'));
      }
    });
  } //

} //_ShortenerPageState
