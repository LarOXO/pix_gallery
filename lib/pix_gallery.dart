import 'package:flutter/material.dart';
import 'package:pix_gallery/router/router.dart';
import 'package:pix_gallery/theme/theme.dart';

/// Главный класс приложения PixGallery.
class PixGallery extends StatelessWidget {
  const PixGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PixGallery',
      theme: liteTheme,
      routes: router,
    );
  }
}
