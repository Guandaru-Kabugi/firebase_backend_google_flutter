import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/repository/posts/posts_repository.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/usecase.dart';

class Getallposts extends Usecase<List<Post>, NoParams>{
  final PostsRepository postsRepository;

  Getallposts({required this.postsRepository});


  @override
  Future<List<Post>> call(NoParams params) {
    return postsRepository.getPosts();
  }}