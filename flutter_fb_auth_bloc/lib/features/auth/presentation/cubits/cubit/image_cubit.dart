import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/core/util/sqlife_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {

  final ImagePicker _picker = ImagePicker();
  final ProfileImageDB _db;

  ImageCubit(this._db) : super(ImageInitial());


  Future<void> loadImage()async{
    if (state is ProfileImageLoading) return;
    emit(ProfileImageLoading());
    try {
      final imagePath = await _db.getImagePath();
      if (imagePath !=null && File(imagePath).existsSync()) {
        emit(ProfileImageLoaded(File(imagePath)));
      } else {
        //Emit ImageInitial when no image is found
        emit(ImageInitial());
      }
    } catch (e) {
      emit(ProfileImageError('Failed to load image: $e'));
    }

  }
  Future<void> pickImage()async{
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 600);
      if (pickedFile == null) {
       await loadImage(); // emit existing image or initial state
        return;
      }
      emit(ProfileImageLoading());
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path)
          .copy('${appDir.path}/$fileName');

      await _db.saveImagePath(savedImage.path);
      emit(ProfileImageLoaded(savedImage));
    } catch (e) {
      emit(ProfileImageError('Failed to pick image: $e'));
    }
  }
}
