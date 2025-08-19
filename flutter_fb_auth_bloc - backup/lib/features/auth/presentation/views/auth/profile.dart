import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/listeners/auth_listeners/auth_listener.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth/profile.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => Home(),), (route) => false);
          }, 
          icon: Icon(Icons.arrow_back)),
        title: Text('My Profile Page'),
        automaticallyImplyLeading: false,
        ),
        
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: authBlocListener,
        builder: (context, state) {
          return ProfileWidget(user: widget.user);
        },
      ),
    );
  }
}
