import 'package:hive/hive.dart';

part 'blog_hive_model.g.dart';

@HiveType(typeId: 0)
class BlogModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final int userId;

  BlogModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });
}
