import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/core/services/injections_imports.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/change_password_bloc/changepassword_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/cubits/cubit/image_cubit.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/blocs/mpesa_bloc/mpesa_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ForgotPasswordBloc>()),
        BlocProvider(create: (_) => sl<ChangepasswordBloc>()),
        BlocProvider(create: (_) => sl<MpesaBloc>()),
        BlocProvider(create: (_) => sl<ImageCubit>()),
        BlocProvider(create: (_) => sl<PostsBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Home(),
      ),
    );
  }
}