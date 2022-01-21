import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortmyurl/repository/repo.dart';
import 'package:shortmyurl/shorttener/bloc/shortener_cubit.dart';
import 'package:shortmyurl/shorttener/view/shorttener_page.dart';

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
          BlocProvider<ShorttenerCubit>(
            create: (BuildContext context) => ShorttenerCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Short my URL',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ShorttenerPage(),
        ));
  }
}
