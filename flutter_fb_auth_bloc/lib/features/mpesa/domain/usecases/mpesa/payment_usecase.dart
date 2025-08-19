import 'package:equatable/equatable.dart';

abstract class PaymentUsecase <Type, Params> {

  Future<Type> call(Params params);
}

class InitiatePaymentWithParams extends Equatable{

  final String phoneNumber;
  final double amount;

  const InitiatePaymentWithParams({required this.phoneNumber, required this.amount});
  @override
  List<Object?> get props => [phoneNumber, amount];
}