import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/shortener/controller/shortener_cubit.dart';
import 'package:shortmyurl/shortener/view/shortener_page.dart';

void main() {
  runApp(const ShortMyUrlApp());
}

class ShortMyUrlApp extends StatelessWidget {
  const ShortMyUrlApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<ShortenerCubit>(
            create: (BuildContext context) => ShortenerCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Short my URL',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const ShortenerPage(),
        ));
  }
}
