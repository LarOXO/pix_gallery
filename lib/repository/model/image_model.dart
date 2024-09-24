import 'package:equatable/equatable.dart';

/// Модель изображения.
///
/// Содержит информацию о URL изображения, количество лайков и просмотров.
class ImageModel extends Equatable {
  /// URL изображения.
  final String imageUrl;

  /// Количество лайков.
  final int likes;

  /// Количество просмотров.
  final int views;

  /// Создает конструктор [ImageModel].
  const ImageModel({
    required this.imageUrl,
    required this.likes,
    required this.views,
  });

  /// Создание экземпляра [ImageModel] из JSON.
  ///
  /// [json] — содержащая данные изображения.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['webformatURL'] as String,
      likes: json['likes'] as int,
      views: json['views'] as int,
    );
  }

  @override
  List<Object?> get props => [imageUrl, likes, views];
}
