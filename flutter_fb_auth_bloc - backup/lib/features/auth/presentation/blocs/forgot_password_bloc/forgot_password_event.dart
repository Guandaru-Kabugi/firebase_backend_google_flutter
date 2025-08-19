part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}
class ResetPasswordEvent extends ForgotPasswordEvent{
  final String email;

  const ResetPasswordEvent({required this.email});
  @override
  List<Object> get props => [email];
}
