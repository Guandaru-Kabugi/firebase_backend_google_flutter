import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/core/util/auth/change_password_success_response.dart';
import 'package:flutter_fb_auth_bloc/features/auth/data/datasources/auth/remote_auth_datasource.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class AuthRemoteImpl extends AuthRepository {
  final RemoteAuthDatasource remoteAuthDatasource;

  AuthRemoteImpl({required this.remoteAuthDatasource});

  @override
  Future<UserCredential> login({required String email, required String password}) {
    return remoteAuthDatasource.login(email: email, password: password);
  }

  @override
  Future<void> logout() {
    return remoteAuthDatasource.logout();
  }

  @override
  Future<UserCredential> signup({required String email, required String password}) {
    return remoteAuthDatasource.signup(email: email, password: password);
  }
  
  @override
  Future<UserCredential> signInWithGoogle() {
    return remoteAuthDatasource.signInWithGoogle();
  }

  @override
  Future<ChangePasswordResponse> changePassword({required String currentPassword, required String newPassword}) {
    return remoteAuthDatasource.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }
  
  @override
  Future<void> forgotPassword({required String email}) {
    return remoteAuthDatasource.forgotPassword(email: email);
  }
  
}