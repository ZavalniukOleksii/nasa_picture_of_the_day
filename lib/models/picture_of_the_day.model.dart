import 'package:equatable/equatable.dart';

class PictureOfTheDayModel with EquatableMixin {
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  const PictureOfTheDayModel({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  // Could have used freezed or JsonSerializable instead of
  // the manual implementation and equatable, but going with manual approach
  // for now to keep the example as simple as possible
  factory PictureOfTheDayModel.fromJson(Map<String, dynamic> json) {
    return PictureOfTheDayModel(
      date: json['date'] as String,
      explanation: json['explanation'] as String,
      hdurl: json['hdurl'] as String,
      mediaType: json['media_type'] as String,
      serviceVersion: json['service_version'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }

  @override
  List<Object?> get props => [
        date,
        explanation,
        hdurl,
        mediaType,
        serviceVersion,
        title,
        url,
      ];
}
