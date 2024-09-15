import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';
import 'package:starlab_tech_test/repos/repos/picture_of_the_day.repo.dart';

import 'picture_of_the_day.repo_test.mocks.dart';

@GenerateMocks([PictureOfTheDayApiInterface])
void main() {
  late PictureOfTheDayRepo pictureOfTheDayRepo;
  late MockPictureOfTheDayApiInterface mockPictureOfTheDayApi;

  setUp(() {
    mockPictureOfTheDayApi = MockPictureOfTheDayApiInterface();

    pictureOfTheDayRepo = PictureOfTheDayRepo(mockPictureOfTheDayApi);
  });

  group('PictureOfTheDayRepo', () {
    const pictureOfTheDayImage = PictureOfTheDayModel(
      date: '2024-09-15',
      explanation: 'NASA picture of the day.',
      title: 'Picture of the Day',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
      hdurl: 'https://example.com/image_hd.jpg',
      serviceVersion: '1.0.0',
    );

    test('returns PictureOfTheDayModel when API call is successful', () async {
      when(mockPictureOfTheDayApi.getPictureOfTheDay())
          .thenAnswer((_) async => pictureOfTheDayImage);

      final result = await pictureOfTheDayRepo.getPictureOfTheDay();

      expect(result, pictureOfTheDayImage);

      verify(mockPictureOfTheDayApi.getPictureOfTheDay()).called(1);
    });

    test('adds the response to cache when API call is successful', () async {
      when(mockPictureOfTheDayApi.getPictureOfTheDay())
          .thenAnswer((_) async => pictureOfTheDayImage);

      await pictureOfTheDayRepo.getPictureOfTheDay();

      expect(pictureOfTheDayRepo.cache.contains(pictureOfTheDayImage), isTrue);
    });

    test('throws an exception when API call fails', () async {
      when(mockPictureOfTheDayApi.getPictureOfTheDay())
          .thenThrow(Exception('Failed to fetch picture of the day'));

      expect(
        () => pictureOfTheDayRepo.getPictureOfTheDay(),
        throwsException,
      );

      verify(mockPictureOfTheDayApi.getPictureOfTheDay()).called(1);
    });
  });
}
