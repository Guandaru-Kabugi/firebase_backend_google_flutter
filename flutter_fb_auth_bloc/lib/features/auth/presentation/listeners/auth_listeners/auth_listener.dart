import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/change_password_bloc/changepassword_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/login.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';

void authBlocListener(BuildContext context, AuthState authState) {
  if (authState is AuthErrorState) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${authState.message}')));
  } else if (authState is AuthSignUpSuccessState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User SignUp Successfully')),
    );
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginPage(),));
  }else if (authState is AuthLoginSuccessState) {
    //final user = authState.userCredential.user!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User Logged in Successfully')),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => Home(),), (route) => false);
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => ProfilePage(user: user,),));
  }else if(authState is AuthLogoutState){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Message: ${authState.message}')));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => Home(),), (route) => false);
  }
}


void changePasswordBlocListener(BuildContext context, ChangepasswordState authState) {
  if (authState is ChangePasswordFailure) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${authState.error}')));
  } else if (authState is ChangePasswordSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(authState.message)),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => Home(),), (route) => false);
  }
}

void forgotPasswordBlocListener(BuildContext context, ForgotPasswordState authState) {
  if (authState is ForgotPasswordError) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${authState.message}')));
  } else if (authState is ForgotPasswordSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(authState.message)),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => Home(),), (route) => false);
  }
}