part of 'picture_of_the_day.bloc.dart';

/// should be done either with freezed or sealed class.
/// picking equatable for simplicity
///
abstract class PictureOfTheDayState extends Equatable {}

class PictureOfTheDayInitial extends PictureOfTheDayState {
  PictureOfTheDayInitial();

  @override
  List<Object?> get props => [];
}

class PictureOfTheDayLoading extends PictureOfTheDayState {
  PictureOfTheDayLoading();

  @override
  List<Object?> get props => [];
}

class PictureOfTheDayImageReady extends PictureOfTheDayState {
  final PictureOfTheDayModel pictureOfTheDay;
  PictureOfTheDayImageReady({
    required this.pictureOfTheDay,
  });

  @override
  List<Object?> get props => [pictureOfTheDay];
}

class PictureOfTheDayVideoReady extends PictureOfTheDayState {
  final PictureOfTheDayModel pictureOfTheDay;
  PictureOfTheDayVideoReady({
    required this.pictureOfTheDay,
  });

  @override
  List<Object?> get props => [pictureOfTheDay];
}

class PictureOfTheDayFailed extends PictureOfTheDayState {
  final String message;
  PictureOfTheDayFailed({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
