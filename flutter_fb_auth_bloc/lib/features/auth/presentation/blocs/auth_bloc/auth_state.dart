part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoadingState extends AuthState{
  const AuthLoadingState();
}
class AuthSignUpSuccessState extends AuthState{
  @override
  List<Object> get props => [userCredential];
  final UserCredential userCredential;
  const AuthSignUpSuccessState({required this.userCredential});
}
class AuthLoginSuccessState extends AuthState{
  @override
  List<Object> get props => [userCredential];
  final UserCredential userCredential;
  const AuthLoginSuccessState({required this.userCredential});
}
class AuthLogoutState extends AuthState{
  final String message;
  const AuthLogoutState({required this.message});
}
class AuthErrorState extends AuthState{
  @override
  List<Object> get props => [code, message];
  final String message;
  final String code;
  const AuthErrorState({required this.message, required this.code});
}
