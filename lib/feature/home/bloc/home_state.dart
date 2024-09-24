part of 'home_bloc.dart';

/// Абстрактный класс для состояний главной галереи.
/// Расширяет [Equatable] для сравнения объектов.
abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Начальное состояние главной галереи.
class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

/// Состояние загрузки изображений.
class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

/// Состояние, когда изображения успешно загружены.
class HomeLoaded extends HomeState {
  /// Создает экземпляр [HomeLoaded].
  ///
  /// [imagesList] — список загруженных изображений.
  HomeLoaded({required this.imagesList});

  /// Список загруженных изображений.
  final List<ImageModel> imagesList;

  @override
  List<Object?> get props => [imagesList];
}

/// Состояние ошибки при загрузке изображений.
class HomeError extends HomeState {
  /// Создает экземпляр [HomeError].
  ///
  /// [message] — сообщение об ошибке.
  HomeError({this.message});

  /// Сообщение об ошибке.
  final Object? message;

  @override
  List<Object?> get props => [message];
}
