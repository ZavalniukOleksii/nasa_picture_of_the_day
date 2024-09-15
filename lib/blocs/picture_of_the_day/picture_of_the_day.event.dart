part of 'picture_of_the_day.bloc.dart';

abstract class PictureOfTheDayEvent {}

class PictureOfTheDayRequest extends PictureOfTheDayEvent {
  final DateTime? date;

  PictureOfTheDayRequest({
    this.date,
  });
}
