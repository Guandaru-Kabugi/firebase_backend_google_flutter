import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/change_password_bloc/changepassword_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/listeners/auth_listeners/auth_listener.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth/change_password_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<ChangepasswordBloc, ChangepasswordState>(
        listener: changePasswordBlocListener,
        builder: (context, state) {
          return ChangePasswordWidget();
        },
      ),
    );
  }
}
