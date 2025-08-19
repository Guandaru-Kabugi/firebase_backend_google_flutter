import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/cubits/cubit/image_cubit.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/auth/change_password.dart';
//import 'package:flutter_fb_auth_bloc/features/auth/domain/entities/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  const ProfileWidget({super.key, required this.user});

  void _handleLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final isLoading = state is AuthLoadingState;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.read<ImageCubit>().pickImage(),
              child: BlocBuilder<ImageCubit, ImageState>(
                builder: (context, state) {
                  if (state is ProfileImageLoaded) {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(state.image),
                    );
                  } else if (state is ProfileImageLoading) {
                    return CircleAvatar(
                      radius: 40,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProfileImageError) {
                    return CircleAvatar(
                      radius: 40,
                      child: Text(
                        'Error: ${state.message}',
                        style: TextStyle(fontSize: 32),
                      ),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 40,
                      child: Text('👨‍💻', style: TextStyle(fontSize: 32)),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Flutter Pro',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(user.email!, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: isLoading ? null : () => _handleLogout(context),
              icon: Icon(Icons.logout),
              label: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              ),
              label: Text('Change Password'),
              icon: Icon(Icons.change_circle),
            ),
          ],
        ),
      ),
    );
  }
}
