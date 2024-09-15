import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';
import 'package:starlab_tech_test/repos/interfaces/picture_of_the_day.repo_interface.dart';

class PictureOfTheDayRepo implements PictureOfTheDayRepoInterface {
  final PictureOfTheDayApiInterface _api;
  static final List<PictureOfTheDayModel> _cache = [];

  PictureOfTheDayRepo(this._api);

  @override
  Future<PictureOfTheDayModel> getPictureOfTheDay() async {
    try {
      final response = await _api.getPictureOfTheDay();

      /// add other data manipulations here. using only cache for simplicity
      _cache.add(response);

      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  List<PictureOfTheDayModel> get cache => _cache;
}
