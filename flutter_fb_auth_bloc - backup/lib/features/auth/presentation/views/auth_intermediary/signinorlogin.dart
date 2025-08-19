import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/auth_intermediary/auth_intermediary.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: AuthIntermediaryWidget(),
    );
  }
}