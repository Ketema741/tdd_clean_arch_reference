import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/errors/exception.dart';
import 'package:tdd_clean_architecture/core/utils/constants.dart';
import 'package:tdd_clean_architecture/features/blog/data/data_source/data_source.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture/features/blog/data/models/blog_hive_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BlogRemoteDataSource dataSource;
  late http.Client mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BlogRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri());
  });

  group('getBlogs', () {
    final sampleJson =
        jsonEncode('[{"id": 1, "title": "Test", "body": "Test", "userId": 1}]');

    test('should perform a GET request and return a list of BlogModel',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(
          sampleJson,
          200,
        ),
      );

      final result = await dataSource.getBlogs();

      // Assert
      expect(result, isA<List<BlogModel>>());
    });

    test(
        'should throw a ServerException if the response status code is not 200',
        () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Act
      final call = dataSource.getBlogs;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
      verify(() => mockHttpClient.get(Uri.parse('$kBaseUrl/posts'))).called(1);
    });
  });

  group('createBlogs', () {
    test('should perform a POST request and return void', () async {
      // Arrange
      when(() => mockHttpClient.post(any(),
          body: any(named: 'body'), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response('Blog created succefully', 201),
      );

      // Act
      final methodCall = dataSource.createBlogs;

      // Assert
      expect(
          methodCall(
            title: "this is title",
            body: "this is body",
            userId: 1,
          ),
          completes);
    });

    test(
        'should throw a ServerException if the response status code is not 201',
        () async {
      // Arrange
      when(() => mockHttpClient.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      // Act
      final call = dataSource.createBlogs;

      // Assert
      expect(() => call(title: 'Test', body: 'Body', userId: 1),
          throwsA(isA<ServerException>()));
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrl/posts'),
            body: '{"title":"Test","body":"Body","userId":1}',
            headers: {'Content-type': 'application/json; charset=UTF-8'},
          )).called(1);
    });
  });
}
