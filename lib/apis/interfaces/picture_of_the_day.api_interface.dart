import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';

abstract class PictureOfTheDayApiInterface {
  Future<PictureOfTheDayModel> getPictureOfTheDay();
}
