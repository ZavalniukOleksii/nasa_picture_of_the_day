import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';
import 'package:starlab_tech_test/repos/interfaces/picture_of_the_day.repo_interface.dart';

part 'picture_of_the_day.event.dart';
part 'picture_of_the_day.state.dart';

class PictureOfTheDayBloc
    extends Bloc<PictureOfTheDayEvent, PictureOfTheDayState> {
  final PictureOfTheDayRepoInterface _pictureOfTheDayRepo;

  PictureOfTheDayBloc(this._pictureOfTheDayRepo)
      : super(PictureOfTheDayInitial()) {
    on<PictureOfTheDayRequest>((event, emit) async {
      /// add logs for possible debugging
      emit(PictureOfTheDayLoading());

      try {
        final pictureOfTheDay = await _pictureOfTheDayRepo.getPictureOfTheDay();

        if (pictureOfTheDay.mediaType == 'video') {
          emit(PictureOfTheDayVideoReady(pictureOfTheDay: pictureOfTheDay));

          return;
        }

        emit(PictureOfTheDayImageReady(pictureOfTheDay: pictureOfTheDay));
      } on Exception catch (exception) {
        emit(PictureOfTheDayFailed(message: exception.toString()));
      }
    });
  }
}
