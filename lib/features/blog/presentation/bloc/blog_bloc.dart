import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/get_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetBlog _blogUser;

  BlogBloc({required GetBlog blogUseCase})
      : _blogUser = blogUseCase,
        super(BlogInitialState()) {
    on<GetBlogsEvent>((GetBlogsEvent event, Emitter<BlogState> emit) async {
      emit(BlogLoadingState());

      final result = await _blogUser.call();

      result.fold((error) => emit(BlogFailureState(error: error.message)),
          (blogs) {
        emit(BlogSuccessState(blogs: blogs));
      });
    });
  }
}
