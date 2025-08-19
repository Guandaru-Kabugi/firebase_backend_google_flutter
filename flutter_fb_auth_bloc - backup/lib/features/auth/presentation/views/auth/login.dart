import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/listeners/auth_listeners/auth_listener.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _handleBackButton(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Home()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              _handleBackButton(context), // Call your custom function
        ),
        title: Center(child: Text('Login')),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: authBlocListener,
        builder: (context, state) {
          return LoginWidget(
            emailController: emailController,
            passwordController: passwordController,
          );
        },
      ),
    );
  }
}
