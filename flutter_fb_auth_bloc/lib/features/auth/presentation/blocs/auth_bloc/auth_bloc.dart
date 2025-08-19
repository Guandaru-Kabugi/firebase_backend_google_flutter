import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/login.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/logout.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/signinwithgoogle.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Signup signup;
  final Login login;
  final Logout logout;
  final SignInWithGoogle signInWithGoogle;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signup,
    required this.login,
    required this.logout,
  }) : super(AuthInitial()) {
    on<SignupEvent>(signupEvent);
    on<LoginEvent>(loginEvent);
    on<LogoutEvent>(logoutEvent);
    on<SignInWithGoogleRequested>(signInWithGoogleRequested);
  }

  FutureOr<void> signupEvent(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await signup(SignupParams(email: event.email, password: event.password));
      emit(AuthSignUpSuccessState(userCredential: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!, code: e.code));
      print(e.message);
    }
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await login(LoginParams(email: event.email, password: event.password));
      emit(AuthLoginSuccessState(userCredential: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!, code: e.code));
      print(e.message);
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      logout.logout();
      emit(AuthLogoutState(message: 'Logout Successful.'));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!, code: e.code));
    }
  }

  FutureOr<void> signInWithGoogleRequested(SignInWithGoogleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await signInWithGoogle.signInWithGoogle();
      emit(AuthLoginSuccessState(userCredential: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(message: e.message!, code: e.code));
    }
  }
}
