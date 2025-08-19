import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class Login {
  final AuthRepository authRepository;

  Login({required this.authRepository});
  Future<UserCredential> login({required String email, required String password}){
    return authRepository.login(email: email, password: password);
  }
}