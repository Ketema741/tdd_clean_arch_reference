part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {}

class GetBlogsEvent extends BlogEvent {
  GetBlogsEvent();

  @override
  List<Object?> get props => [];
}

class CreateBlogsEvent extends BlogEvent {
  final String title;
  final String body;
  final int userId;
  CreateBlogsEvent(
      {required this.title, required this.body, required this.userId});

  @override
  List<Object?> get props => [title, body, userId];
}
