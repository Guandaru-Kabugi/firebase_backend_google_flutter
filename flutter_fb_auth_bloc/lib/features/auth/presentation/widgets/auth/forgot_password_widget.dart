import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/forgot_password_bloc/forgot_password_bloc.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
 
  
  

  void handleResetPassword(BuildContext context){
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final email = emailController.text;
      context.read<ForgotPasswordBloc>().add(ResetPasswordEvent(email: email));
    }    
  }

  ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  "Recover Password!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Insert Your Email", suffixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return "Please a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextButton.icon(
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => handleResetPassword(context), 
                  label: Text('Click Here', style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.email),
                  )
            ],
          ),
        ),
      ),
    );
  }
}