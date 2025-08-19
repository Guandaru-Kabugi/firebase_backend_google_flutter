import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fb_auth_bloc/core/util/firebase_notification_utils.dart';
import 'package:flutter_fb_auth_bloc/core/util/sqlife_helper.dart';
import 'package:flutter_fb_auth_bloc/features/auth/data/datasources/auth/remote_auth_datasource.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/change_password.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/forgot_password.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/change_password_bloc/changepassword_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/data/datasources/mpesa/mpesa_data_source.dart';
import 'package:flutter_fb_auth_bloc/features/posts/data/datasources/posts/post_remote_datasource.dart';
import 'package:flutter_fb_auth_bloc/features/auth/data/repository/auth/auth_remote_impl.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/data/repository/mpesa/payment_repository_impl.dart';
import 'package:flutter_fb_auth_bloc/features/posts/data/repository/posts/posts_repository_impl.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/login.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/logout.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/signinwithgoogle.dart';
import 'package:flutter_fb_auth_bloc/features/auth/domain/usecases/auth/signup.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/domain/usecases/mpesa/payment_process.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/create_new_post.dart';
import 'package:flutter_fb_auth_bloc/features/posts/domain/usecases/posts/getallposts.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/mpesa/presentation/blocs/mpesa_bloc/mpesa_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/posts/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/cubits/cubit/image_cubit.dart';
import 'package:flutter_fb_auth_bloc/features/auth/presentation/views/home/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseUtils = FirebaseUtils();
  await firebaseUtils.initFirebase();
  final authRepository = AuthRemoteImpl(
    remoteAuthDatasource: RemoteAuthDatasource(),
  );
  final postsRepository = PostsRepositoryImpl(
    postRemoteDatasource: PostRemoteDatasource(),
  );
  final userSignUp = Signup(authRepository: authRepository);
  final userLogin = Login(authRepository: authRepository);
  final logout = Logout(authRepository: authRepository);
  final changePass = ChangePassword(authRepository: authRepository);
  final forgotPass = ForgotPassword(authRepository: authRepository);
  final signInWithGoogle = SignInWithGoogle(authRepository: authRepository);
  final fetchPosts = Getallposts(postsRepository: postsRepository);
  final createPosts = CreateNewPost(postsRepository: postsRepository);
  final mpesaRepository = PaymentRepositoryImpl(
    mpesaDataSource: MpesaDataSourceImpl(),
  );
  final mpesaDataSource = MpesaDataSourceImpl();
  mpesaDataSource.initialize();
  final mpesaInitializer = PaymentProcess(mpesaRepository: mpesaRepository);
  final profileDB = ProfileImageDB();
  await profileDB.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create:(_) => ForgotPasswordBloc(forgotPass),),
        BlocProvider(create:(_) => ChangepasswordBloc(changePassword: changePass),),
        BlocProvider(create: (_) => MpesaBloc(mpesaInitializer)),
        BlocProvider(
          create: (_) => ImageCubit(profileDB)..loadImage(), //cascade operator
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            login: userLogin,
            logout: logout,
            signup: userSignUp,
            signInWithGoogle: signInWithGoogle,
          ),
        ),
        BlocProvider(
          create: (context) =>
              PostsBloc(getAllPosts: fetchPosts, createNewPost: createPosts),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}
