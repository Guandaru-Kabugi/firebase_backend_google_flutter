import 'package:flutter_fb_auth_bloc/features/posts/data/models/posts/posts_model.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
  Future<Post> createPost({required PostsModel postModel});
}