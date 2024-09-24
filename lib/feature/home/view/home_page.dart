import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pix_gallery/feature/home/bloc/home_bloc.dart';
import 'package:pix_gallery/feature/home/home.dart';

/// Главная страница приложения.
///
/// Отображает список изображений и управляет состоянием загрузки,
/// ошибок и успешной загрузки с помощью [HomeBloc].
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Запуск события загрузки изображений при инициализации.
    context.read<HomeBloc>().add(FetchImages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const SliverAppBar(
            title: Text('PixGallery'),
            floating: true,
            snap: true,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              // Повторная загрузка изображений при обновлении.
              final completer = Completer();
              context.read<HomeBloc>().add(FetchImages(completer: completer));
              return completer.future;
            },
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // Обработка различных состояний.
              if (state is HomeLoading) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: Text('Загружается...')),
                  ),
                );
              } else if (state is HomeError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text('${state.message ?? "Неизвестная ошибка"}'),
                    ),
                  ),
                );
              } else if (state is HomeLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final image = state.imagesList[index];
                        return GestureDetector(
                          child: ImageCard(image: image),
                        );
                      },
                      childCount: state.imagesList.length,
                    ),
                  ),
                );
              }
              // Состояние, когда нет изображений.
              return const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100, // Укажите подходящую высоту
                  child: Center(child: Text('Нет изображения')),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
