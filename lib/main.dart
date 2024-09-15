import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:starlab_tech_test/apis/apis/picture_of_the_day.api.dart';
import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/pages/picture_of_the_day.page.dart';

final _dependencies = GetIt.instance;

void main() {
  _dependencies.registerSingleton<PictureOfTheDayApiInterface>(
    PictureOfTheDayApi(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PictureOfTheDayPage(),
    );
  }
}
