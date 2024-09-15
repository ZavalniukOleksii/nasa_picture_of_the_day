import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starlab_tech_test/blocs/picture_of_the_day/picture_of_the_day.bloc.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';
import 'package:starlab_tech_test/repos/interfaces/picture_of_the_day.repo_interface.dart';

import 'picture_of_the_day.cubit_test.mocks.dart';

@GenerateMocks([PictureOfTheDayRepoInterface])
void main() {
  late PictureOfTheDayRepoInterface mockPictureOfTheDayRepo;
  late PictureOfTheDayBloc pictureOfTheDayBloc;

  void setUpDependencies() {
    GetIt.instance.registerSingleton<PictureOfTheDayRepoInterface>(
      MockPictureOfTheDayRepoInterface(),
    );
  }

  setUpAll(setUpDependencies);

  setUp(() {
    mockPictureOfTheDayRepo =
        GetIt.instance.get<PictureOfTheDayRepoInterface>();
    pictureOfTheDayBloc = PictureOfTheDayBloc(mockPictureOfTheDayRepo);
  });

  tearDown(() {
    pictureOfTheDayBloc.close();
  });

  group('PictureOfTheDayBloc', () {
    const pictureOfTheDayImage = PictureOfTheDayModel(
      date: '2024-09-15',
      explanation: 'NASA picture of the day.',
      title: 'Picture of the Day',
      url: 'https://example.com/image.jpg',
      mediaType: 'image',
      hdurl: 'https://example.com/image_hd.jpg',
      serviceVersion: '1.0.0',
    );

    const pictureOfTheDayVideo = PictureOfTheDayModel(
      date: '2024-09-15',
      explanation: 'NASA video of the day.',
      title: 'Video of the Day',
      url: 'https://example.com/video.mp4',
      mediaType: 'video',
      hdurl: 'https://example.com/video_hd.mp4',
      serviceVersion: '1.0.0',
    );

    test('initial state is PictureOfTheDayInitial', () {
      expect(pictureOfTheDayBloc.state, PictureOfTheDayInitial());
    });

    blocTest<PictureOfTheDayBloc, PictureOfTheDayState>(
      'emits [PictureOfTheDayLoading, PictureOfTheDayImageReady] when '
      'PictureOfTheDayRequest is added and image data is returned',
      build: () {
        when(mockPictureOfTheDayRepo.getPictureOfTheDay())
            .thenAnswer((_) async => pictureOfTheDayImage);
        return pictureOfTheDayBloc;
      },
      act: (bloc) => bloc.add(PictureOfTheDayRequest()),
      expect: () => [
        PictureOfTheDayLoading(),
        PictureOfTheDayImageReady(pictureOfTheDay: pictureOfTheDayImage),
      ],
      verify: (_) {
        verify(mockPictureOfTheDayRepo.getPictureOfTheDay()).called(1);
      },
    );

    blocTest<PictureOfTheDayBloc, PictureOfTheDayState>(
      'emits [PictureOfTheDayLoading, PictureOfTheDayVideoReady] when '
      'PictureOfTheDayRequest is added and video data is returned',
      build: () {
        when(mockPictureOfTheDayRepo.getPictureOfTheDay())
            .thenAnswer((_) async => pictureOfTheDayVideo);
        return pictureOfTheDayBloc;
      },
      act: (bloc) => bloc.add(PictureOfTheDayRequest()),
      expect: () => [
        PictureOfTheDayLoading(),
        PictureOfTheDayVideoReady(pictureOfTheDay: pictureOfTheDayVideo),
      ],
      verify: (_) {
        verify(mockPictureOfTheDayRepo.getPictureOfTheDay()).called(1);
      },
    );

    blocTest<PictureOfTheDayBloc, PictureOfTheDayState>(
      'emits [PictureOfTheDayLoading, PictureOfTheDayFailed] when '
      'PictureOfTheDayRequest is added and an exception is thrown',
      build: () {
        when(mockPictureOfTheDayRepo.getPictureOfTheDay())
            .thenThrow(Exception('Failed to fetch picture of the day'));
        return pictureOfTheDayBloc;
      },
      act: (bloc) => bloc.add(PictureOfTheDayRequest()),
      expect: () => [
        PictureOfTheDayLoading(),
        PictureOfTheDayFailed(
            message: 'Exception: Failed to fetch picture of the day'),
      ],
      verify: (_) {
        verify(mockPictureOfTheDayRepo.getPictureOfTheDay()).called(1);
      },
    );
  });
}
