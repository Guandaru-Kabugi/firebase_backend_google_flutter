import 'package:flutter_fb_auth_bloc/features/mpesa/domain/entities/mpesa/payment.dart';

class PaymentModel extends Payment {
  const PaymentModel({
    required super.phoneNumber,
    required super.amount,
    super.businessCode = "174379",
    super.reference = "Test Payment",
    super.description = "Test Payment Desc",
    super.remarks = "Remarks for Payment"
  });

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'amount': amount,
      'businessShortCode': businessCode,
      'accountReference': reference,
      'transactionDesc': description,
      'remarks': remarks
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      phoneNumber: map['phoneNumber'],
      amount: map['amount'],
      businessCode: map['businessShortCode'] ?? "174379",
      reference: map['accountReference'] ?? "Test Payment",
      description: map['transactionDesc'] ?? "Test Payment Desc",
      remarks: map['Remarks'] ?? "Remarks for payment"
    );
  }

  // Create model from domain entity
  factory PaymentModel.fromEntity(Payment payment) {
    return PaymentModel(
      phoneNumber: payment.phoneNumber,
      amount: payment.amount,
      businessCode: payment.businessCode,
      reference: payment.reference,
      description: payment.description,
      remarks: payment.remarks
    );
  }
}
