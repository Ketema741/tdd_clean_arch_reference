import 'package:equatable/equatable.dart';

class BlogEntity extends Equatable {
  const BlogEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int id;
  final String title;
  final String body;
  final int userId;

  const BlogEntity.empty()
      : this(
          id: 1,
          title: "_empty.title",
          body: "_empty.body",
          userId: 1,
        );

  @override
  List<Object> get props => [id, title, body, userId];
}
