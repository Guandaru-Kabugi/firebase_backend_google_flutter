part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostLoadingState extends PostsState{
  const PostLoadingState();
}
class CreatePostLoadingState extends PostsState{
  const CreatePostLoadingState();
}
class PostSuccessState extends PostsState{
  final List<Post> posts;

  const PostSuccessState({required this.posts});

   @override
  List<Object> get props => [posts];
}

class PostCreatedSuccessState extends PostsState{
  final Post post;
  const PostCreatedSuccessState(this.post);
  @override
  List<Object> get props => [post];
}

class PostErrorState extends PostsState{
  final String message;

  const PostErrorState({required this.message});

   @override
  List<Object> get props => [message];

}

