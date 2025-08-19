import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/blocs/posts_bloc/posts_bloc.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPostFormState();
  }
}

class _AddPostFormState extends State<AddPostForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _idController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = context.watch<PostsBloc>().state;
    final isLoading = state is CreatePostLoadingState;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _userIdController,
            decoration: const InputDecoration(labelText: "User ID"),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? "Enter User ID" : null,
          ),
          TextFormField(
            controller: _idController,
            decoration: const InputDecoration(labelText: "Post ID"),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? "Enter Post ID" : null,
          ),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
            validator: (value) => value!.isEmpty ? "Enter title" : null,
          ),
          TextFormField(
            controller: _bodyController,
            decoration: const InputDecoration(labelText: "Content"),
            maxLines: 3,
            validator: (value) => value!.isEmpty ? "Enter content" : null,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isLoading ? null : () {
              if (_formKey.currentState!.validate()) {
                final userId = int.parse(_userIdController.text);
                final id = int.parse(_idController.text);
                final title = _titleController.text;
                final body = _bodyController.text;

                context.read<PostsBloc>().add(
                  CreateNewPostEvent(userId: userId, id: id, title: title, body: body),
                );

                Navigator.pop(context);
              }
            },
            child: isLoading ? const Text('Wait while we submit') : const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
