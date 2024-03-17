import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/errors/failures.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/create_blog.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/get_blog.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/bloc/bloc.dart';

class MockGetBlog extends Mock implements GetBlog {}

class MockCreateBlog extends Mock implements CreateBlog {}

class MockCreateBlogParams extends Mock implements CreateBlogParams {}

void main() {
  late MockGetBlog mockGetBlog;
  late MockCreateBlog mockCreateBlog;
  late BlogBloc blogBloc;

  setUp(() {
    mockGetBlog = MockGetBlog();
    mockCreateBlog = MockCreateBlog();
    blogBloc = BlogBloc(
      getBlogUseCase: mockGetBlog,
      createBlogUseCase: mockCreateBlog,
    );

    registerFallbackValue(MockCreateBlogParams());
  });

  group('GetBlogsEvent', () {
    final blogs = [
      const BlogEntity(id: 1, title: 'Test', body: 'Body', userId: 1)
    ];

    blocTest<BlogBloc, BlogState>(
      'emits [BlogLoadingState, BlogSuccessState] when GetBlogsEvent is added',
      build: () {
        when(() => mockGetBlog.call()).thenAnswer((_) async => Right(blogs));
        return blogBloc;
      },
      act: (bloc) => bloc.add(GetBlogsEvent()),
      expect: () => [BlogLoadingState(), BlogSuccessState(blogs: blogs)],
    );

    blocTest<BlogBloc, BlogState>(
      'emits [BlogLoadingState, BlogFailureState] when GetBlogsEvent is added and fails',
      build: () {
        when(() => mockGetBlog.call()).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return blogBloc;
      },
      act: (bloc) => bloc.add(GetBlogsEvent()),
      expect: () => [BlogLoadingState(), BlogFailureState(error: 'Error')],
    );
  });

  group('CreateBlogsEvent', () {
    blocTest<BlogBloc, BlogState>(
      'emits [CreatingBlogState, BlogCreatedState] when CreateBlogsEvent is added',
      build: () {
        when(() => mockCreateBlog.call(any()))
            .thenAnswer((_) async => const Right(null));
        return blogBloc;
      },
      act: (bloc) =>
          bloc.add(CreateBlogsEvent(title: 'Test', body: 'Body', userId: 1)),
      expect: () => [CreatingBlogState(), BlogCreatedState()],
    );

    blocTest<BlogBloc, BlogState>(
      'emits [CreatingBlogState, BlogFailureState] when CreateBlogsEvent is added and fails',
      build: () {
        when(() => mockCreateBlog.call(any())).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return blogBloc;
      },
      act: (bloc) =>
          bloc.add(CreateBlogsEvent(title: 'Test', body: 'Body', userId: 1)),
      expect: () => [CreatingBlogState(), BlogFailureState(error: 'Error')],
    );
  });
}
