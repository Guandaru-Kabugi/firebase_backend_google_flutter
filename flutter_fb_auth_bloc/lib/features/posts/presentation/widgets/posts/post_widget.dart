import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/entities/posts/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      tileColor: Colors.teal,
      subtitle: Text(post.body),
      leading: CircleAvatar(child: Text(post.id.toString()),),
    );
  }
}