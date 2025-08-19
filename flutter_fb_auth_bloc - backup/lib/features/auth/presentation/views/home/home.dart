import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/core/util/firebase_notification_utils.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/login.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/profile.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/views/posts/post_page.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/widgets/home/home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseUtils _firebaseUtils = FirebaseUtils();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    bool permissionGranted = await FirebaseUtils.reqForNotification();
    if (permissionGranted) {
      await _firebaseUtils.initFirebaseHome();
      await FirebaseUtils.requestFirebaseToken();
      await FirebaseUtils.firebaseSetUnsetTopic(
        isSubscribe: true,
        strTopic: "test_topic",
      );
    } else {
      print("Notification permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final isLoggedIn = state is AuthLoginSuccessState;

    return Scaffold(
      // backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Builder(
          builder: (context) {
            if (state is AuthLoginSuccessState) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(user: state.userCredential.user!),
                    ),
                  );
                },
                child: Text(
                  'Hi, ${state.userCredential.user!.email}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            } else {
              return const Text(
                'Welcome',
                style: TextStyle(color: Colors.white, fontSize: 16),
              );
            }
          },
        ),

        actions: [
          if (state is AuthLoginSuccessState)
      TextButton.icon(
        onPressed: () {
          context.read<AuthBloc>().add(LogoutEvent());
        },
        label: const Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.logout),
      ),
        ],
      ),
      body: HomeWidget(),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
              ),
              onPressed: () {
                if (isLoggedIn) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PostPage()),
                  );
                } else {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },

              label: isLoggedIn ? Text('View Posts') : Text('Click to Login To View Posts'),
              icon: Icon(Icons.article),
            ),
          ],
        ),
      ),
    );
  }
}
