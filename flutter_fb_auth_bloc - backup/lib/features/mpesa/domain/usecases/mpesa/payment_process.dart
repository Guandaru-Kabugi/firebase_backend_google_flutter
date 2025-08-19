import 'package:flutter_fb_auth_bloc/core/util/mpesa/mpesa_result_success_helper.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/entities/mpesa/payment.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/repository/mpesa/mpesa_repository.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/usecases/mpesa/payment_usecase.dart';

class PaymentProcess extends PaymentUsecase<PaymentResult, InitiatePaymentWithParams> {
  final MpesaRepository mpesaRepository;

  PaymentProcess({required this.mpesaRepository});
  @override
  Future<PaymentResult> call(InitiatePaymentWithParams params) async {
    // Validate input
    if (params.phoneNumber.isEmpty) {
      return PaymentResult.failure("Phone number is required");
    }

    if (!params.phoneNumber.startsWith('254') || params.phoneNumber.length != 12) {
      return PaymentResult.failure("Please enter a valid phone number starting with 254");
    }

    if (params.amount <= 0) {
      return PaymentResult.failure("Please enter a valid amount greater than 0");
    }

    // Create payment entity and process it through the repository
    final payment = Payment(
      phoneNumber: params.phoneNumber,
      amount: params.amount,
    );

    // Proceed with payment process (implementation needed)
    return await mpesaRepository.initiatePayment(payment);
    
    
    // return PaymentResult.success("Payment initiated successfully");
  }
}