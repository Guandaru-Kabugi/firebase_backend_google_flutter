part of 'changepassword_bloc.dart';

abstract class ChangepasswordEvent extends Equatable {
  const ChangepasswordEvent();

  @override
  List<Object> get props => [];

  
}
class ChangePasswordSubmitted extends ChangepasswordEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordSubmitted({
    required this.currentPassword,
    required this.newPassword,
  });
    @override
  List<Object> get props => [currentPassword, newPassword];
}
