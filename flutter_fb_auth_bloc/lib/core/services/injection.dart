part of 'injections_imports.dart';

Future<void> initializeDependencies() async {
  //Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //utils
  final firebaseUtils = FirebaseUtils();
  await firebaseUtils.initFirebase();
  sl.registerLazySingleton(() => firebaseUtils);

  //Datasources
  sl.registerLazySingleton(() => RemoteAuthDatasource());
  sl.registerLazySingleton(() => PostRemoteDatasource());
  sl.registerLazySingleton(() => MpesaDataSourceImpl()..initialize());

  //repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRemoteImpl(remoteAuthDatasource: sl()));
  sl.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(postRemoteDatasource: sl()),
  );
  sl.registerLazySingleton<MpesaRepository>(() => PaymentRepositoryImpl(mpesaDataSource: sl()));

  //Use Case
  sl.registerLazySingleton(() => Signup(authRepository: sl()));
  sl.registerLazySingleton(() => Login(authRepository: sl()));
  sl.registerLazySingleton(() => Logout(authRepository: sl()));
  sl.registerLazySingleton(() => ChangePassword(authRepository: sl()));
  sl.registerLazySingleton(() => ForgotPassword(authRepository: sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(authRepository: sl()));
  sl.registerLazySingleton(() => Getallposts(postsRepository: sl()));
  sl.registerLazySingleton(() => CreateNewPost(postsRepository: sl()));
  sl.registerLazySingleton(() => PaymentProcess(mpesaRepository: sl()));

  //local db

  final profileDB = ProfileImageDB();
  await profileDB.init();
  sl.registerLazySingleton(() => profileDB);

  //blocs and cubits
  sl.registerFactory(
    () => AuthBloc(
      signInWithGoogle: sl(),
      signup: sl(),
      login: sl(),
      logout: sl(),
    ),
  );
  sl.registerFactory(() => ForgotPasswordBloc(sl()));
  sl.registerFactory(() => ChangepasswordBloc(changePassword: sl()));
  sl.registerFactory(() => PostsBloc(getAllPosts: sl(), createNewPost: sl()));
  sl.registerFactory(() => MpesaBloc(sl()));
  sl.registerFactory(() => ImageCubit(sl())..loadImage());
}
