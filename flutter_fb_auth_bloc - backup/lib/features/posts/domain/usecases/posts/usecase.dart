import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/features/posts/data/models/posts/posts_model.dart';

abstract class Usecase <Type, Params> {
  Future<Type> call(Params params);
}

// NoParams for cases where we don't pass anything
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
class CreateNewPostParams extends Equatable{

  final PostsModel postsModel;

  const CreateNewPostParams({required this.postsModel});
  @override
  List<Object?> get props => [postsModel];
}