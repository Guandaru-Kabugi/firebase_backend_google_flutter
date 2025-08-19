import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/features/posts/data/models/posts/posts_model.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/create_new_post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/getallposts.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final Getallposts getAllPosts;
  final CreateNewPost createNewPost;
  PostsBloc({required this.createNewPost, required this.getAllPosts}) : super(PostsInitial()) {
    on<FetchPostsEvent>(fetchPostsEvent);
    on<CreateNewPostEvent>(createNewPostEvent);
  }

  FutureOr<void> fetchPostsEvent(FetchPostsEvent event, Emitter<PostsState> emit) async{
    emit(PostLoadingState());
    try {
      final posts = await getAllPosts(const NoParams());
      emit(PostSuccessState(posts: posts));
    } catch (e) {
      print('Error: $e');
      emit(PostErrorState(message:'Failed to fetch posts: $e'));
    }
  }

  FutureOr<void> createNewPostEvent(CreateNewPostEvent event, Emitter<PostsState> emit) async{
    emit(CreatePostLoadingState());
    try {
      final post = await createNewPost(
        CreateNewPostParams(postsModel: PostsModel(userId: event.userId, id: event.id, title: event.title, body: event.body))); 
      emit(PostCreatedSuccessState(post));
    } catch (e) {
      print(e.toString());
      emit(PostErrorState(message: 'Failed to create new post: $e'));
    }
  }
}
