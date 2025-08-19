import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/core/util/auth/change_password_success_response.dart';

abstract class AuthRepository {
  Future<UserCredential> login({
    required String email,
    required String password,
  });
  Future<UserCredential> signup({
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithGoogle();
  Future<void> logout();
  Future<ChangePasswordResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> forgotPassword({required String email});
}
