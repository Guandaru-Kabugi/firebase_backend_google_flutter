import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class Signup {
  final AuthRepository authRepository;

  Signup({required this.authRepository});

  Future<UserCredential> signup({required String email, required String password}){
    return authRepository.signup(email: email, password: password);
  }
}