part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserSignIn extends AppUserState {
  final User user;
  const AppUserSignIn({required this.user});
}
