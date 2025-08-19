import 'package:flutter_fb_auth_bloc/features/posts/data/datasources/posts/post_remote_datasource.dart';
import 'package:flutter_fb_auth_bloc/features/posts/data/models/posts/posts_model.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/repository/posts/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository{
  final PostRemoteDatasource postRemoteDatasource;

  PostsRepositoryImpl({required this.postRemoteDatasource});
  @override
  Future<List<Post>> getPosts() async {
    return await postRemoteDatasource.fetchAllPosts();
  }

  @override
  Future<Post> createPost({required PostsModel postModel}) {
    return postRemoteDatasource.createPost(postModel: postModel);
  }

}