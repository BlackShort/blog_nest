import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:nest/core/theme/theme.dart';
import 'package:nest/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nest/features/auth/presentation/pages/signin_page.dart';
import 'package:nest/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:nest/features/blog/presentation/pages/blog_page.dart';
import 'package:nest/init_dependencies/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserSignIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nest',
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserSignIn;
        },
        builder: (context, isSignIn) {
          if (isSignIn) {
            return const BlogPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}
