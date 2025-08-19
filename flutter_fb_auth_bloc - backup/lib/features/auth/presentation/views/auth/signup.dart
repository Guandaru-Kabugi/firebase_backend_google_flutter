import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/listeners/auth_listeners/auth_listener.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth/signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  void _handleBackButton(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Home()),
      (route) => false,
    );
  }
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  

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
          onPressed: () => _handleBackButton(context), 
          icon: Icon(Icons.arrow_back)),
        title: Center(child: Text('SignUp'))),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: authBlocListener,
        builder: (context, state) {
          return SignupWidget(
            emailController: emailController,
            passwordController: passwordController,
          );
        },
      ),
    );
  }
}
