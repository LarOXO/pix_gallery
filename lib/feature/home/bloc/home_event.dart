part of 'home_bloc.dart';

/// Абстрактный класс для событий главной галереи.
/// Расширяет [Equatable] для сравнения объектов.
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Событие для запроса загрузки изображений.
class FetchImages extends HomeEvent {
  /// Создает экземпляр [FetchImages].
  ///
  /// [completer] — опциональный комплитер для обработки завершения.
  FetchImages({this.completer});

  /// Комплитер, который можно использовать для уведомления о завершении события.
  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
