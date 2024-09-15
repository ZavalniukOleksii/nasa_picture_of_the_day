import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:starlab_tech_test/apis/apis/picture_of_the_day.api.dart';
import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/pages/picture_of_the_day.page.dart';
import 'package:starlab_tech_test/repos/interfaces/picture_of_the_day.repo_interface.dart';
import 'package:starlab_tech_test/repos/repos/picture_of_the_day.repo.dart';

final _dependencies = GetIt.instance;

void main() {
  _setupApiDependencies();
  _setupRepoDependencies();

  runApp(const MyApp());
}

void _setupApiDependencies() {
  // add any tweaks to client here
  final httpClient = http.Client();

  _dependencies.registerSingleton<PictureOfTheDayApiInterface>(
    PictureOfTheDayApi(httpClient),
  );
}

void _setupRepoDependencies() {
  _dependencies.registerSingleton<PictureOfTheDayRepoInterface>(
    PictureOfTheDayRepo(_dependencies.get<PictureOfTheDayApiInterface>()),
  );
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
