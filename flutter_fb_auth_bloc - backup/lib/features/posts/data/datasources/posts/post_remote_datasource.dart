import 'dart:convert';

import 'package:flutter_fb_auth_bloc/features/posts/data/models/posts/posts_model.dart';
//import 'package:flutter_fb_auth_bloc/features/auth/domain/entities/posts/post.dart';
import 'package:http/http.dart' as http;

class PostRemoteDatasource {
  Future<List<PostsModel>> fetchAllPosts () async{
    var client = http.Client();

    try {
      final response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {
        'User-Agent': 'FlutterAuthPostsApp/1.0',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = json.decode(response.body);
        final listOfPosts = decodedResponse.map((post) =>
        PostsModel.fromJson(post as Map<String, dynamic>),
        ).toList();
        print(listOfPosts);
        return listOfPosts;
      }
      else{
        throw Exception('Failed to fetch posts: Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }finally{
      client.close();
    }
  }
  Future<PostsModel> createPost({required PostsModel postModel}) async{
     var client = http.Client();

    try {
      final response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {
        'User-Agent': 'FlutterAuthPostsApp/1.0',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        },
        body: json.encode(postModel.toJson())
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final PostsModel createdPost = PostsModel.fromJson(decodedResponse);
        return createdPost;
      }else{
         throw Exception(
        'Failed to create post. Status code: ${response.statusCode}, '
        'Response body: ${response.body}',
      );
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }finally{
      client.close();
    }

  }
}