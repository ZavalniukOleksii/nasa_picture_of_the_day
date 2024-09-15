part of 'picture_of_the_day.bloc.dart';

abstract class PictureOfTheDayState {}

class PictureOfTheDayInitial extends PictureOfTheDayState {
  PictureOfTheDayInitial();
}

class PictureOfTheDayLoading extends PictureOfTheDayState {
  PictureOfTheDayLoading();
}

class PictureOfTheDayImageReady extends PictureOfTheDayState {
  final PictureOfTheDayModel pictureOfTheDay;
  PictureOfTheDayImageReady({
    required this.pictureOfTheDay,
  });
}

class PictureOfTheDayVideoReady extends PictureOfTheDayState {
  final PictureOfTheDayModel pictureOfTheDay;
  PictureOfTheDayVideoReady({
    required this.pictureOfTheDay,
  });
}

class PictureOfTheDayFailed extends PictureOfTheDayState {
  final String message;
  PictureOfTheDayFailed({
    required this.message,
  });
}
