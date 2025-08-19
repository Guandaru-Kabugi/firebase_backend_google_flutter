import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/listeners/posts_listeners/post_listeners.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/widgets/posts/post_widget.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/widgets/posts/showmodalfunctionsheet.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<PostsBloc>().add(FetchPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Page'),
        actions: [
          IconButton(
            onPressed: () => showAddPostModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: postListeners,
        builder: (context, state) {
          return BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PostSuccessState) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostWidget(post: post);
                  },
                );

              } else if (state is PostCreatedSuccessState) {
                return Card(
                  child: PostWidget(post: state.post),
                );

              } else if (state is PostErrorState) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text(''));
              }
            },
          );
        },
      ),
    );
  }
}
