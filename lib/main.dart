import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pix_gallery/const.dart';
import 'package:pix_gallery/pix_gallery.dart';
import 'package:pix_gallery/repository/adstract_image_repository.dart';
import 'package:pix_gallery/repository/image_repository.dart';

void main() {
  // Регистрация репозитория изображений в GetIt.
  GetIt.I.registerLazySingleton<AbstractImageRepository>(
    () => ImageRepository(dio: Dio(), apiKey: apiKey),
  );
  runApp(const PixGallery());
}
