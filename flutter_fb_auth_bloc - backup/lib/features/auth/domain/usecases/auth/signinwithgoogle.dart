import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository authRepository;

  SignInWithGoogle({required this.authRepository});

  Future<UserCredential> signInWithGoogle(){
    return authRepository.signInWithGoogle();
  }
}