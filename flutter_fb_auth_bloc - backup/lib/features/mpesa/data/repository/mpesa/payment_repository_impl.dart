import 'package:flutter_fb_auth_bloc/core/util/mpesa/mpesa_result_success_helper.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/data/datasources/mpesa/mpesa_data_source.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/data/models/mpesa/payment_model.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/entities/mpesa/payment.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/repository/mpesa/mpesa_repository.dart';

class PaymentRepositoryImpl implements MpesaRepository{
  final MpesaDataSource mpesaDataSource;

  PaymentRepositoryImpl({required this.mpesaDataSource});
  @override
  Future<PaymentResult> initiatePayment(Payment payment) async {
    try {
      final paymentModel = PaymentModel.fromEntity(payment);
      final result = await mpesaDataSource.initiateSTKPush(paymentModel);
      if (result['success']) {
        return PaymentResult.success('Please check your phone for the STK push prompt',
        data: result['data']);
      }else{
        return PaymentResult.failure(result['message']);
      }
    } catch (e) {
      return PaymentResult.failure('An error occurred: ${e.toString()}');
    }
  }
}