import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starlab_tech_test/apis/apis/picture_of_the_day.api.dart';
import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/models/picture_of_the_day.model.dart';

part 'picture_of_the_day.event.dart';
part 'picture_of_the_day.state.dart';

class PictureOfTheDayBloc
    extends Bloc<PictureOfTheDayEvent, PictureOfTheDayState> {
  final PictureOfTheDayApiInterface _pictureOfTheDayApi;

  PictureOfTheDayBloc(this._pictureOfTheDayApi)
      : super(PictureOfTheDayInitial()) {
    on<PictureOfTheDayRequest>((event, emit) async {
      /// add logs for possible debugging
      emit(PictureOfTheDayLoading());

      try {
        final pictureOfTheDay = await _pictureOfTheDayApi.getPictureOfTheDay();

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
