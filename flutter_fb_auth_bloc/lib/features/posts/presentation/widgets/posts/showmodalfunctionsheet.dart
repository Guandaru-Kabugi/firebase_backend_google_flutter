import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/widgets/posts/add_new_post.dart';

void showAddPostModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: AddPostForm(),
      );
    },
  );
}
