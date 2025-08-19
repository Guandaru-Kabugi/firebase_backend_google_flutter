import 'package:flutter_fb_auth_bloc/core/util/mpesa/mpesa_result_success_helper.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/entities/mpesa/payment.dart';

abstract class MpesaRepository {

  Future<PaymentResult> initiatePayment(Payment payment);

}

