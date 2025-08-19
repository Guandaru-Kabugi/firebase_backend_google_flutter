import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/core/util/usecases/common_use_case.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class Login extends Usecase<UserCredential, LoginParams> {
  final AuthRepository authRepository;

  Login({required this.authRepository});
  
  @override
  Future<UserCredential> call(LoginParams params) {
    return authRepository.login(email: params.email, password: params.password);
  }
}
class LoginParams extends Equatable{
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}