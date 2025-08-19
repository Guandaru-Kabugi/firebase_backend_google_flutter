part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends AuthEvent{

  @override
  List<Object> get props => [email, password];
  final String email;
  final String password;

  const SignupEvent({required this.email, required this.password});
}
class LoginEvent extends AuthEvent{

  @override
  List<Object> get props => [email, password];
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class SignInWithGoogleRequested extends AuthEvent {}

class LogoutEvent extends AuthEvent{
  const LogoutEvent();

}