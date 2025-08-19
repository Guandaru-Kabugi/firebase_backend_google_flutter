import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String phoneNumber;
  final double amount;
  final String businessCode;
  final String reference;
  final String description;
  final String remarks;

  const Payment({
    required this.phoneNumber,
    required this.amount,
    this.businessCode = "174379",
    this.reference = "Test Payment",
    this.description = "Test Payment Desc",
    this.remarks = "Remarks on Test payment"
  });

  @override
  List<Object?> get props => [
    phoneNumber,
    amount,
    businessCode,
    reference,
    description,
    remarks
  ];
}
