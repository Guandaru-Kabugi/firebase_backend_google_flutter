import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/usecases/mpesa/payment_process.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/usecases/mpesa/payment_usecase.dart';

part 'mpesa_event.dart';
part 'mpesa_state.dart';

class MpesaBloc extends Bloc<MpesaEvent, MpesaState> {
  final PaymentProcess paymentProcess;
  MpesaBloc(this.paymentProcess) : super(MpesaInitial()) {
    on<MpesaSTKPushEvent>(mpesaSTKPushEvent);
  }

  FutureOr<void> mpesaSTKPushEvent(MpesaSTKPushEvent event, Emitter<MpesaState> emit) async{
    emit(MpesaLoadingState());
    try {
      final result = await paymentProcess(InitiatePaymentWithParams(phoneNumber: event.phoneNumber, amount: event.amount));
      final message = result.message;
      emit(MpesaLoadedState(message: message));
      await Future.delayed(Duration(seconds: 1));
      emit(MpesaResetState());
      
    } catch (e) {
      print('Error: $e');
      emit(MpesaErrorState(message: 'Unexpected Error: $e'));
    }
  }
}
