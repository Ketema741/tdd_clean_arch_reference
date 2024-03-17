part of 'blog_bloc.dart';

abstract class BlogState extends Equatable{}

class BlogInitialState extends BlogState {
  @override
  List<Object?> get props => [];
}

class BlogLoadingState extends BlogState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BlogSuccessState extends BlogState {
  final List<BlogEntity> blogs;
  BlogSuccessState({required this.blogs});
  
  @override
  List<Object?> get props => blogs.map((blog)=>blog.id).toList(

  );
}

class BlogFailureState extends BlogState {
  final String error;
  BlogFailureState({required this.error});
  
  @override
  List<Object?> get props => [error];
}

class CreatingBlogState extends BlogState {
  
  CreatingBlogState();
  
  @override
  List<Object?> get props => [];
}

class BlogCreatedState extends BlogState {
  BlogCreatedState();
  
  @override
  List<Object?> get props => [];
}
