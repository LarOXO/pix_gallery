import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_gallery/const.dart';
import 'package:pix_gallery/repository/repository.dart';

// Мок для Dio.
class MockDio extends Mock implements Dio {}

void main() {
  late ImageRepository imageRepository;
  late MockDio mockDio;

  // Установка моков перед каждым тестом.
  setUp(() {
    mockDio = MockDio();
    imageRepository = ImageRepository(dio: mockDio, apiKey: apiKey);
  });

  group('ImageRepository - ', () {
    test('возвращает список изображений при успешном ответе, status 200',
        () async {
      // Пример данных, возвращаемых API.
      final mockResponseData = {
        'hits': [
          {
            'webformatURL': 'https://example.com/image1.jpg',
            'likes': 10,
            'views': 100,
          },
          {
            'webformatURL': 'https://example.com/image2.jpg',
            'likes': 20,
            'views': 200,
          },
        ]
      };

      // Выдает успешный ответ.
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: mockResponseData,
                statusCode: 200,
                requestOptions: RequestOptions(path: ''),
              ));

      // Выполнение метода.
      final images = await imageRepository.fetchImages();

      // Ожидаемый результат.
      expect(images, [
        const ImageModel(
          imageUrl: 'https://example.com/image1.jpg',
          likes: 10,
          views: 100,
        ),
        const ImageModel(
          imageUrl: 'https://example.com/image2.jpg',
          likes: 20,
          views: 200,
        ),
      ]);

      // Проверка, что Dio был вызван с нужными параметрами.
      verify(() => mockDio.get(
            'https://pixabay.com/api/',
            queryParameters: {
              'key': apiKey,
              'image_type': 'photo',
              'per_page': 100,
              'page': 1,
            },
          )).called(1);
    });

    test('NetworkException при ошибке сети', () async {
      // Выдает ошибки сети.
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => imageRepository.fetchImages(),
        throwsA(isA<NetworkException>()),
      );
    });

    test(
        'HttpException при ошибочном status code 400',
        () async {
      // Выдает неуспешный ответ.
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: {},
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(
        () => imageRepository.fetchImages(),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
