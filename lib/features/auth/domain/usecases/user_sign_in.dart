import 'package:fpdart/fpdart.dart';
import 'package:nest/core/error/failure.dart';
import 'package:nest/core/usecase/usecase.dart';
import 'package:nest/core/common/entities/user.dart';
import 'package:nest/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;
  const UserSignIn({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
