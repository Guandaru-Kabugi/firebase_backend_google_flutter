import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/login.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/signup.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/forgot_password_page.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/views/mpesa/mpesa.dart';

class AuthIntermediaryWidget extends StatelessWidget {
  const AuthIntermediaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('If you have an account, click login', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginPage(),));
                }, 
                label: Text('Login'),
                icon: Icon(Icons.login),
                ),
            ),
            SizedBox(height: 20,),
             Text('Forgot Password?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => ForgotPasswordPage(),));
                }, 
                label: Text('Click Here'),
                icon: Icon(Icons.login),
                ),
            ),
            SizedBox(height: 20,),
            Text('Create New Account', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => SignupPage(),), (route) => false);
                }, 
                label: Text('Signup',),
                icon: Icon(Icons.create),
                ),
            ),
            SizedBox(height: 20,),
            Text('Make Mpesa Payment', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context) => MpesaPage(),));
                }, 
                label: Text('Pay'),
                icon: Icon(Icons.payment),
                ),
            ),
      
          ],
      ),
    );
  }
}