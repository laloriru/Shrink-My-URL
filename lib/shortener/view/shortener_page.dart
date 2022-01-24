import 'package:flutter/material.dart';
import 'package:shortmyurl/shortener/controller/shortener_state.dart';
import 'package:shortmyurl/shortener/view/form.dart';
import 'package:shortmyurl/shortener/view/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/snackbar.dart';
import 'package:shortmyurl/shortener/controller/shortener_cubit.dart';
//For tests run flutter test integration_test

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
  } //

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        return ShortenerForm();
      } else if (state is LoadingState) {
        return const Center(
            child: SizedBox(
          child: CircularProgressIndicator(),
          height: 40.0,
          width: 40.0,
        ));
      } else if (state is ShortenedState) {
        return listView();
      } else if (state is RetrievedState) {
        CustomSnackbar(context).show(
            '${state.link['full_link'].toString()} is the full link from alias: ${state.link['alias'].toString()}',
            Colors.green,
            Colors.white,
            const Duration(seconds: 5));
        return listView();
      } else if (state is ErrorState) {
        CustomSnackbar(context)
            .show(state.errorMessage, Colors.red, Colors.white);
        return listView();
      } else {
        return const Center(child: Text('Please verify internet connection.'));
      }
    });
  } //

  Widget listView() {
    return ListView(children: <Widget>[
      ShortenerForm(),
      ShortenerLinkList(),
    ]);
  } //

} //_ShortenerPageState
