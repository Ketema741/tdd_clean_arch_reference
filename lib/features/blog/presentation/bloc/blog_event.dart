part of 'blog_bloc.dart';

abstract class BlogEvent {}

class GetBlogsEvent extends BlogEvent {
  GetBlogsEvent();
}
