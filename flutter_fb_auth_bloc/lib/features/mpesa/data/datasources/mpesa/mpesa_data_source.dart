import 'package:flutter/rendering.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/data/models/mpesa/payment_model.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

abstract class MpesaDataSource {
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment);
}

class MpesaDataSourceImpl implements MpesaDataSource {

  //initialize mpesa sdk

  void initialize(){
    MpesaFlutterPlugin.setConsumerKey("gO47X4yXG70dvysCGhfceXAxMtJDYZCo75Wge9XHPmAIWGpA");
    MpesaFlutterPlugin.setConsumerSecret("59W4qHkkpuknBmiLOyu0ZqaRFlZ6TT3wsBwY3xH65vuckaYG4tLx94NddAFe0jUf");
  }

  @override
  Future<Map<String, dynamic>> initiateSTKPush(PaymentModel payment) async{
    try {
      final result = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: payment.businessCode, 
        transactionType: TransactionType.CustomerPayBillOnline, 
        amount: payment.amount, 
        partyA: payment.phoneNumber, 
        partyB: payment.businessCode, 
        callBackURL: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"), 
        accountReference: payment.reference, 
        phoneNumber: payment.phoneNumber, 
        baseUri: Uri.parse(
              "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"), 
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
        transactionDesc: payment.remarks
        );
       debugPrint("Transaction Result: $result");
      return {
        'success': true,
        'message' : 'STK Push sent successfully',
        'data' : result
      };
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        'success': false,
        'message': e.toString(),
      };      
    }
  }
  
}