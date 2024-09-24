import 'package:dio/dio.dart';
import 'package:pix_gallery/repository/repository.dart';

/// Репозиторий для получения изображений из API Pixabay.
///
/// Реализует [AbstractImageRepository] и предоставляет доступ к изображениям через HTTP-запросы.
class ImageRepository implements AbstractImageRepository {
  /// Создает экземпляр [ImageRepository].
  ///
  /// [dio] — экземпляр Dio для выполнения HTTP-запросов,
  /// [apiKey] — ключ API для доступа к сервису Pixabay.
  ImageRepository({required this.dio, required this.apiKey});

  final Dio dio;
  final String apiKey;

  @override
  Future<List<ImageModel>> fetchImages() async {
    try {
      final response = await dio.get(
        'https://pixabay.com/api/',
        queryParameters: {
          'key': apiKey,
          'image_type': 'photo',
          'per_page': 100,
          'page': 1,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['hits'];
        return data.map((json) => ImageModel.fromJson(json)).toList();
      } else {
        throw HttpException('Не удалось загрузить изображения. '
            'Код статуса: ${response.statusCode}');
      }
    } on DioException {
      throw NetworkException('Проблемы с сетью');
    }
  }
}

/// Исключение, возникающее при ошибках HTTP.
class HttpException implements Exception {
  /// Создает экземпляр [HttpException].
  HttpException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Исключение, возникающее при проблемах с сетью.
class NetworkException implements Exception {
  /// Создает экземпляр [NetworkException].
  NetworkException(this.message);

  final String message;

  @override
  String toString() => message;
}
