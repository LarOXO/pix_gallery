import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pix_gallery/feature/home/bloc/home_bloc.dart';
import 'package:pix_gallery/feature/home/home.dart';
import 'package:pix_gallery/repository/repository.dart';

/// Определение маршрутов приложения.
final router = {
  '/': (context) => BlocProvider(
        create: (context) => HomeBloc(
          GetIt.I<AbstractImageRepository>(),
        ),
        child: const HomePage(),
      ),
};
