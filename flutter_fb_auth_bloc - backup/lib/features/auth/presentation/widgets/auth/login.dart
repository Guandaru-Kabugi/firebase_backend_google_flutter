import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  void _handleLogIn(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    context.read<AuthBloc>().add(LoginEvent(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final isLoading = state is AuthLoadingState;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Welcome Back!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: false,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _handleLogIn(context),
                child: isLoading ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ) : Text('Login'),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: OutlinedButton.icon(
                onPressed: (){
                  context.read<AuthBloc>().add(SignInWithGoogleRequested());
                }, 
                icon: FaIcon(FontAwesomeIcons.google, color: Color.fromARGB(255,66, 133, 244),),
                label: Text('Sign in With Google',  style: TextStyle(fontSize: 16, color: Colors.black87))),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SignupPage()),
                  );
                },
                child: Text('Want to Sign Up? Click here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
