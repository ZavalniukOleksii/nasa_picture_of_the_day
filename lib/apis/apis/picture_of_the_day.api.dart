import 'dart:convert';

import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';
import 'package:http/http.dart' as http;

class PictureOfTheDayApi implements PictureOfTheDayApiInterface {
  final http.Client httpClient;

  PictureOfTheDayApi(this.httpClient);

  static final apiUri = Uri.parse(
      'https://api.nasa.gov/planetary/apod?api_key=IHE6wfIXbhRbcJKIZQTcJt0MmvCPQffEa3Ox70ey');

  // we can add some additional headers here if needed
  @override
  Future<PictureOfTheDayModel> getPictureOfTheDay() async {
    final jsonResult = await httpClient.get(apiUri);

    if (![200, 202].contains(jsonResult.statusCode)) {
      throw Exception(
        'Failed to load picture of the day. Please try again later.',
      );
    }

    final result = jsonDecode(jsonResult.body);

    return PictureOfTheDayModel.fromJson(result);
  }
}
