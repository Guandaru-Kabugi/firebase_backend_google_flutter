
import 'package:flutter_fb_auth_bloc/core/util/usecases/common_use_case.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/repository/posts/posts_repository.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/usecase_params.dart';

class CreateNewPost extends Usecase<Post, CreateNewPostParams>{
  final PostsRepository postsRepository;

  CreateNewPost({required this.postsRepository});
  @override
  Future<Post> call(CreateNewPostParams params) {
    return postsRepository.createPost(postModel: params.postsModel);
  }



}