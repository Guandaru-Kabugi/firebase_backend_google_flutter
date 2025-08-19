part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends PostsEvent{
  const FetchPostsEvent();
}
class CreateNewPostEvent extends PostsEvent{
  final int userId;
  final int id;
  final String title;
  final String body;
  const CreateNewPostEvent({required this.userId,required this.id, required this.title, required this.body});
  @override
  List<Object> get props => [userId, id, title, body];
}
