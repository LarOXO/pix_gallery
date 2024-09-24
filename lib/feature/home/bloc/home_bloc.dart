import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_gallery/repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

/// BLoC для управления состоянием экрана главной галереи.
/// Обрабатывает события, связанные с загрузкой изображений.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Создает экземпляр [HomeBloc].
  ///
  /// [imageRepository] — репозиторий для загрузки изображений.
  HomeBloc(this.imageRepository) : super(HomeInitial()) {
    // Обработка события [FetchImages].
    on<FetchImages>((event, emit) async {
      try {
        // Выдает состояния загрузки, если текущее состояние не [HomeLoaded].
        if (state is! HomeLoaded) {
          emit(HomeLoading());
        }

        // Получение списка изображений.
        final imageList = await imageRepository.fetchImages();
        emit(HomeLoaded(imagesList: imageList));
      } catch (e) {
        // Выдает состояния ошибки в случае исключения.
        emit(HomeError(message: e.toString()));
      } finally {
        // Выдает комплитер, если он был передан.
        event.completer?.complete();
      }
    });
  }

  /// Репозиторий для работы с изображениями.
  final AbstractImageRepository imageRepository;
}