part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitialState extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogSuccessState extends BlogState {
  final List<BlogEntity> blogs;
  BlogSuccessState({required this.blogs});
}

class BlogFailureState extends BlogState {
  final String error;
  BlogFailureState({required this.error});
}
