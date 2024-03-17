import 'package:tdd_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/create_blog.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// what does our class depends on? Anwer: BlogRepository
// how can we create fake version of that dependency: Answer: use moctail
// how do we control what our dependecy do: Answer: using mocktail API

class MockBlogRepository extends Mock implements BlogRepository {}

void main() {
  late CreateBlog createBlog;
  late BlogRepository repository;

  setUp(() {
    repository = MockBlogRepository();
    createBlog = CreateBlog(repository);
  });

  const params = CreateBlogParams.empty();
  test("should call the [BlogRepository.createBlog]", () async {
    // arrange
    when(
      () => repository.createBlogs(
        title: any(named: "title"),
        body: any(named: "body"),
        userId: any(named: "userId"),
      ),
    ).thenAnswer((_) async => const Right(null));
    // act
    final result = await createBlog(params);

    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createBlogs(
        title: params.title,
        body: params.body,
        userId: params.userId,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
