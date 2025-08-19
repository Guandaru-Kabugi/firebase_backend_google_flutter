import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/blocs/posts_bloc/posts_bloc.dart';

void postListeners(BuildContext context, PostsState state){
  if (state is CreatePostLoadingState) {
    
  }else if(state is PostErrorState){
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
  }else if(state is PostCreatedSuccessState){
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Response: ${state.post}')));
  }

}