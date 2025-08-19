import 'package:equatable/equatable.dart';

abstract class ChangePasswordUsecase <Type, Params> {
  Future<Type> call (Params params);
}

class ChangePassWithParams extends Equatable{

  final String currentPassword;
  final String newPassword;

  const ChangePassWithParams({required this.currentPassword, required this.newPassword});

  @override
  List<Object?> get props => [currentPassword, newPassword];

}