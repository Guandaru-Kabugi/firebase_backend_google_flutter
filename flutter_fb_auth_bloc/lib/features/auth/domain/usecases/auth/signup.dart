import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/core/util/usecases/common_use_case.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class Signup extends Usecase<UserCredential, SignupParams> {
  final AuthRepository authRepository;

  Signup({required this.authRepository});
  
  @override
  Future<UserCredential> call(SignupParams params) {
    return authRepository.signup(email: params.email, password: params.password);
  }
}

class SignupParams extends Equatable{
  final String email;
  final String password;

  const SignupParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}