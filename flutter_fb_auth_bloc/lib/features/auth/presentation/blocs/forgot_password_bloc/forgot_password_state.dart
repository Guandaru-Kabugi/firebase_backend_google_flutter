part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState{}
class ForgotPasswordSuccess extends ForgotPasswordState{
  final String message;
  const ForgotPasswordSuccess({required this.message});
}
class ForgotPasswordError extends ForgotPasswordState{
  final String message;
  const ForgotPasswordError({required this.message});

}

