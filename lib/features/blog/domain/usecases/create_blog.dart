import 'package:tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:equatable/equatable.dart';

class CreateBlog extends UseCaseWithParams<void, CreateBlogParams> {
  final BlogRepository _repository;

  CreateBlog(this._repository);

  @override
  ResultVoid call(CreateBlogParams params) => _repository.createBlogs(
        title: params.title,
        body: params.body,
        userId: params.userId,
      );
}

class CreateBlogParams extends Equatable {
  const CreateBlogParams({
    required this.title,
    required this.body,
    required this.userId,
  });

  final String title;
  final String body;
  final int userId;

  const CreateBlogParams.empty()
      : this(
          title: "_empty.title",
          body: "_empty.body",
          userId: 0,
        );

  @override
  List<Object?> get props => [title, body, userId];
}
