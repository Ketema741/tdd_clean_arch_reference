import 'package:tdd_clean_architecture/features/blog/domain/entities/blog_entity.dart';
import 'package:tdd_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/get_blog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// what does our class depends on? Anwer: BlogRepository
// how can we create fake version of that dependency: Answer: use moctail
// how do we control what our dependecy do: Answer: using mocktail API

class MockBlogRepository extends Mock implements BlogRepository {}

void main() {
  late GetBlog getBlog;
  late BlogRepository repository;

  setUp(() {
    repository = MockBlogRepository();
    getBlog = GetBlog(repository);
  });

  final tResponse = [const BlogEntity.empty()];

  test("should call the [BlogRepository.getBlog] and return [List<BlogEntity>]",
      () async {
    // arrange
    when(
      () => repository.getBlogs(),
    ).thenAnswer((_) async => Right(tResponse));
    // act
    final result = await getBlog();

    // assert
    expect(result, equals(Right<dynamic, List<BlogEntity>>(tResponse)));
    verify(
      () => repository.getBlogs(),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
