import 'package:flutter_fb_auth_bloc/features/auth/domain/repository/auth/auth_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout({required this.authRepository});
  Future<void> logout(){
    return authRepository.logout();
  }
}