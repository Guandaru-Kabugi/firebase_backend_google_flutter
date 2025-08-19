import 'package:flutter_fb_auth_bloc/core/util/auth/change_password_success_response.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/change_password_usecase.dart';

class ChangePassword extends ChangePasswordUsecase<ChangePasswordResponse, ChangePassWithParams>{

  final AuthRepository authRepository;

  ChangePassword({required this.authRepository});
  @override
  Future <ChangePasswordResponse> call(ChangePassWithParams params) async {
    if (params.newPassword.trim().length < 8 ) {
      throw Exception('Password must be at least 8 characters long');      
    }
    return authRepository.changePassword(currentPassword: params.currentPassword, newPassword: params.newPassword);
  }
}