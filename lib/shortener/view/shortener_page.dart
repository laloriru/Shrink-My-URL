import 'package:flutter/material.dart';
import 'package:shortmyurl/shortener/controller/shortener_state.dart';
import 'package:shortmyurl/shortener/view/form.dart';
import 'package:shortmyurl/shortener/view/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/controller/shortener_cubit.dart';

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
        return ShortenerForm(context: context).form();
      } else if (state is LoadingState) {
        return const Center(
            child: SizedBox(
          child: CircularProgressIndicator(),
          height: 40.0,
          width: 40.0,
        ));
      } else if (state is ShortenedState) {
        return ListView(children: <Widget>[
          ShortenerForm(context: context).form(),
          ShortenerLinkList(context: context, linkToAdd: state.link).list(),
        ]);
      } else if (state is ErrorState) {
        SnackBar _snackBar = SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(30.0),
            content: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ));
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        });
        return ShortenerForm(context: context).form();
      } else {
        return const Center(child: Text('Please verify internet connection.'));
      }
    });
  } //

} //_ShortenerPageState
