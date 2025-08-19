part of 'mpesa_bloc.dart';

abstract class MpesaEvent extends Equatable {
  const MpesaEvent();

  @override
  List<Object> get props => [];
}
class MpesaSTKPushEvent extends MpesaEvent {
  final double amount;
  final String phoneNumber;

  const MpesaSTKPushEvent({required this.amount, required this.phoneNumber});
  @override
  List<Object> get props => [amount, phoneNumber];
}