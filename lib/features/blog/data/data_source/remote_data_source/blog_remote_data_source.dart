import 'dart:convert';
import 'package:tdd_clean_architecture/core/errors/exception.dart';
import 'package:tdd_clean_architecture/core/utils/constants.dart';
import 'package:tdd_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:http/http.dart' as http;

abstract class BlogRemoteDataSource {
  Future<List<BlogModel>> getBlogs();
  Future<void> createBlogs({
    required String title,
    required String body,
    required int userId,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final http.Client client;

  BlogRemoteDataSourceImpl({required this.client});
  @override
  Future<List<BlogModel>> getBlogs() async {
    final response = await client.get(
      Uri.parse('$kBaseUrl/posts'),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => BlogModel.fromMap(item)).toList();
    } else {
      throw ServerException(message: response.body.toString());
    }
  }

  @override
  @override
  Future<void> createBlogs({
    required String title,
    required String body,
    required int userId,
  }) async {
    final response = await client.post(
      Uri.parse('$kBaseUrl/posts'),
      body: jsonEncode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      return Future.value();
    } else {
      throw ServerException(message: response.body.toString());
    }
  }
}
