import 'package:pix_gallery/repository/model/image_model.dart';

/// Абстрактный класс для репозиторий изображений.
///
/// Определяет метод для получения списка изображений.
abstract class AbstractImageRepository {
  /// Получает список изображений.
  ///
  /// Возвращает [Future], который завершится списком [ImageModel].
  Future<List<ImageModel>> fetchImages();
}