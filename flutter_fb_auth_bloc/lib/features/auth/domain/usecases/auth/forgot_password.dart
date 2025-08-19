import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/forgot_password_usecase.dart';

class ForgotPassword extends ForgotPasswordUsecase<void, ForgotPasswordParams>{
  final AuthRepository authRepository;

  ForgotPassword({required this.authRepository});
  @override
  Future<void> call(ForgotPasswordParams params) {
    if (params.email.trim().isEmpty||!params.email.trim().contains('@')) {
      throw Exception('Email must be valid');  
    }
    return authRepository.forgotPassword(email: params.email);
  }

}