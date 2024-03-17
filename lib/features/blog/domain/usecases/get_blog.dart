import 'package:tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';
import 'package:tdd_clean_architecture/features/blog/domain/repositories/blog_repository.dart';

class GetBlog extends UseCaseWithoutParams<List<BlogEntity>> {
  final BlogRepository _repository;

  GetBlog(this._repository);

  @override
  ResultFuture<List<BlogEntity>> call() => _repository.getBlogs();
}
