import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/change_password_bloc/changepassword_bloc.dart';

class ChangePasswordWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChangepasswordBloc>().state;
    final isLoading = state is ChangePasswordLoading;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
              child: Text(
                "Change Password Here!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: 20),
              TextFormField(
                controller: currentPasswordController,
                // obscureText: true,
                decoration: InputDecoration(labelText: "Current Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your current password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: newPasswordController,
                // obscureText: true,
                decoration: InputDecoration(labelText: "New Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a new password";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: confirmPasswordController,
                // obscureText: true,
                decoration: InputDecoration(labelText: "Confirm New Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your new password";
                  }
                  if (value != newPasswordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (formKey.currentState!.validate()) {
                          final currentPassword = currentPasswordController.text
                              .trim();
                          final newPassword = newPasswordController.text.trim();

                          context.read<ChangepasswordBloc>().add(
                            ChangePasswordSubmitted(
                              currentPassword: currentPassword,
                              newPassword: newPassword,
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text("Reset"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
