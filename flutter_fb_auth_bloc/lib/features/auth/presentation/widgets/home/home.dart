import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth_intermediary/signinorlogin.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 400).animate(controller)
      ..addListener(() {
        setState(() {}); // Triggers rebuild to reflect animation value
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final isLoggedIn = state is AuthLoginSuccessState;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          isLoggedIn ? 'Hi, ${state.userCredential.user!.email}' : '',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 40),
        Text(
          'Welcome to this Flutter App',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 40),
        SizedBox(height: 30),
        Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Image.network(
              fit: BoxFit.cover,
              width: animation.value,
              height: animation.value,
              'https://tse4.mm.bing.net/th/id/OIP.j4oq-4C2nkvqkb0_wiRZnQHaE8?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
            ),
          ),
        ),
        SizedBox(height: 40),
        if (!isLoggedIn)
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.greenAccent,
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => WelcomePage()));
            },
            label: Text('Click to continue'),
            icon: Icon(Icons.start),
          ),
      ],
    );
  }
}
