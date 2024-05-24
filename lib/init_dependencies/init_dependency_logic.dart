part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // hive
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton<Box>(() => Hive.box(name: 'blogs'));

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(
        internetConnection: serviceLocator<InternetConnection>(),
      ));
}

void _initAuth() {
  // datasource
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
            supabaseClient: serviceLocator<SupabaseClient>(),
          ));

  // repository
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: serviceLocator<AuthRemoteDataSource>(),
        connectionChecker: serviceLocator<ConnectionChecker>(),
      ));

  // usecases
  serviceLocator.registerFactory(() => UserSignUp(
        authRepository: serviceLocator<AuthRepository>(),
      ));
  serviceLocator.registerFactory(() => UserSignIn(
        authRepository: serviceLocator<AuthRepository>(),
      ));
  serviceLocator.registerFactory(() => CurrentUser(
        authRepository: serviceLocator<AuthRepository>(),
      ));

  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userSignIn: serviceLocator<UserSignIn>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ));
}

void _initBlog() {
  // datasource
  serviceLocator
      .registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(
            supabaseClient: serviceLocator<SupabaseClient>(),
          ));
  serviceLocator
      .registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(
            box: serviceLocator<Box>(),
          ));

  // repo
  serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator<BlogRemoteDataSource>(),
        blogLocalDataSource: serviceLocator<BlogLocalDataSource>(),
        connectionChecker: serviceLocator<ConnectionChecker>(),
      ));

  // usecases
  serviceLocator.registerFactory(() => UploadBlog(
        blogRepository: serviceLocator<BlogRepository>(),
      ));
  serviceLocator.registerFactory(() => GetAllBlogs(
        blogRepository: serviceLocator<BlogRepository>(),
      ));

  // bloc
  serviceLocator.registerLazySingleton(() => BlogBloc(
        uploadBlog: serviceLocator<UploadBlog>(),
        getAllBlog: serviceLocator<GetAllBlogs>(),
      ));
}
