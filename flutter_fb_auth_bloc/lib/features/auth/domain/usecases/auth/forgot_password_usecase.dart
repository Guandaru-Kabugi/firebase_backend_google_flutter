import 'package:equatable/equatable.dart';

abstract class ForgotPasswordUsecase <Type, Params> {
  Future<Type> call (Params params);
}
class ForgotPasswordParams extends Equatable{
  final String email;

  const ForgotPasswordParams({required this.email});
  @override
  List<Object?> get props => [email];

}