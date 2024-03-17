import 'dart:convert';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = BlogModel.empty();

  test("should be subclass of [BlogEntity]", () {
    // arrange

    // act

    // assert
    expect(tModel, isA<BlogEntity>());
  });

  final tJson = fixture('blog.json');
  final tMap = jsonDecode(tJson) as DataMap;
  group(
    "fromMap",
    () {
      test(
        "should return [BlogModel] with the right data",
        () {
          // arrange
          final tMap = jsonDecode(tJson) as DataMap;
          // act

          // assert
          final result = BlogModel.fromMap(tMap);
          expect(result, equals(tModel));
        },
      );
    },
  );
  group(
    "fromJson",
    () {
      test(
        "should return [Json] with the right data",
        () {
          // arrange
          // act

          // assert
          final result = BlogModel.fromJson(tJson);
          expect(result, equals(tModel));
        },
      );
    },
  );
  group(
    "toMap",
    () {
      test(
        "should return [Map] with the right data",
        () {
          // arrange
          // act

          // assert
          final result = tModel.toMap();
          expect(result, equals(tMap));
        },
      );
    },
  );
  group(
    "toJson",
    () {
      test(
        "should return [Json] string with the right data",
        () {
          // arrange
          final tJson = jsonEncode({
            "id": 1,
            "title": "_empty.title",
            "body": "_empty.body",
            "userId": 1
          });
          // act

          // assert
          final result = tModel.toJson();
          expect(result, equals(tJson));
        },
      );
    },
  );
  group(
    "copyWith",
    () {
      test(
        "should return [BlogModel] with the right data",
        () {
          // arrange
          // act
          final result = tModel.copyWith(title: "new title");

          // assert
          expect(result.title, equals("new title"));
        },
      );
    },
  );
}
