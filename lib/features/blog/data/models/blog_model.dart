import 'dart:convert';

import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';

class BlogModel extends BlogEntity {
  const BlogModel({
    required super.id,
    required super.title,
    required super.body,
    required super.userId,
  });

  BlogModel copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }

  const BlogModel.empty()
      : this(
          id: 1,
          title: "_empty.title",
          body: "_empty.body",
          userId: 1,
        );

  BlogModel.fromMap(DataMap map)
      : this(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
          userId: map['userId'] as int,
        );

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(jsonDecode(source) as DataMap);
  DataMap toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'userId': userId,
      };

  String toJson() => jsonEncode(toMap());
}
