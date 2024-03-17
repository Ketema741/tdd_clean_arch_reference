import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';

abstract class BlogRepository {
  ResultVoid createBlogs({
    required String title,
    required String body,
    required int userId,
  });
  ResultFuture<List<BlogEntity>> getBlogs();
}
