part of 'image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}
class ProfileImageLoading extends ImageState {}

class ProfileImageLoaded extends ImageState {
  final File image;
  const ProfileImageLoaded(this.image);

  @override
  List<Object> get props => [image];
}

class ProfileImageError extends ImageState {
  final String message;
  const ProfileImageError(this.message);

  @override
  List<Object> get props => [message];
}

