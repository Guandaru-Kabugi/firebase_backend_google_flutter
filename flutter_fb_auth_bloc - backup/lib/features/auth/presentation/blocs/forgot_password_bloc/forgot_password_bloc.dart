import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/forgot_password.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/forgot_password_usecase.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPassword forgotPassword;
  ForgotPasswordBloc(this.forgotPassword) : super(ForgotPasswordInitial()) {
    on<ResetPasswordEvent>(resetPasswordEvent);
  }

  FutureOr<void> resetPasswordEvent(ResetPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      await forgotPassword(ForgotPasswordParams(email: event.email));
      emit(ForgotPasswordSuccess(message: "A message has been sent to your email"));
    } catch (e) {
      print(e.toString());
      emit(ForgotPasswordError(message: 'An error occurred: $e'));
    }
  }
}
