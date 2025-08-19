part of 'changepassword_bloc.dart';

abstract class ChangepasswordState extends Equatable {
  const ChangepasswordState();
  
  @override
  List<Object> get props => [];
}

final class ChangepasswordInitial extends ChangepasswordState {}

class ChangePasswordLoading extends ChangepasswordState {}

class ChangePasswordSuccess extends ChangepasswordState {
  final String message;
  const ChangePasswordSuccess(this.message);
    @override
  List<Object> get props => [message];
}

class ChangePasswordFailure extends ChangepasswordState {
  final String error;
  const ChangePasswordFailure(this.error);
    @override
  List<Object> get props => [error];
}