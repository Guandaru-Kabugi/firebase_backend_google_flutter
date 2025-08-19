import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';

class PostsModel extends Post {
  const PostsModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    userId: json['userId'], 
    id: json['id'], 
    title: json['title'], 
    body: json['body']
    );
  Map<String, dynamic> toJson () {
    return {
      'userId': userId,
      'id' : id,
      'title' : title,
      'body' : body
    };
  }
}
