import 'package:equatable/equatable.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/create_blog.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/get_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc({
    required GetBlog getBlogUseCase,
    required CreateBlog createBlogUseCase,
  })  : _getBlog = getBlogUseCase,
        _createBlog = createBlogUseCase,
        super(BlogInitialState()) {
    on<GetBlogsEvent>(_getBlogHandler);
    on<CreateBlogsEvent>(_createBlogHandler);
  }

  final GetBlog _getBlog;
  final CreateBlog _createBlog;

  Future<void> _createBlogHandler(
    CreateBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    
    emit(CreatingBlogState());

    final result = await _createBlog.call(
      CreateBlogParams(
        title: event.title,
        body: event.body,
        userId: event.userId,
      ),
    );

    result.fold((error) => emit(BlogFailureState(error: error.message)),
        (blogs) {
      emit(BlogCreatedState());
    });
  }

  Future<void> _getBlogHandler(
    GetBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoadingState());

    final result = await _getBlog.call();

    result.fold((error) => emit(BlogFailureState(error: error.message)),
        (blogs) {
      emit(BlogSuccessState(blogs: blogs));
    });
  }
}
