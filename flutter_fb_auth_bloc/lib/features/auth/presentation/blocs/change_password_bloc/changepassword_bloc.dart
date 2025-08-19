import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/change_password.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/change_password_usecase.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'changepassword_event.dart';
part 'changepassword_state.dart';

class ChangepasswordBloc extends Bloc<ChangepasswordEvent, ChangepasswordState> {
  final ChangePassword changePassword;
  ChangepasswordBloc({required this.changePassword}) : super(ChangepasswordInitial()) {
    on<ChangePasswordSubmitted>(changePasswordSubmitted);
  }

  FutureOr<void> changePasswordSubmitted(ChangePasswordSubmitted event, Emitter<ChangepasswordState> emit) async{
    emit(ChangePasswordLoading());
    try {
      final response = await changePassword(ChangePassWithParams(currentPassword: event.currentPassword, newPassword: event.newPassword));
      
      if (response.success) {
        print(response.message);
        emit(ChangePasswordSuccess(response.message));
      }else{
        emit(ChangePasswordFailure('Failed to change Password'));
      }
    } catch (e) {
      print(e.toString());
      emit(ChangePasswordFailure('Failed to change Password: $e'));
    }
  }
}
