import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/listeners/auth_listeners/auth_listener.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth/forgot_password_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recovery Password', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: forgotPasswordBlocListener,
        builder: (context, state) {
          return ForgotPasswordWidget();
        },
      ),
    );
  }
}
