import 'package:fpdart/fpdart.dart';
import 'package:nest/core/error/failure.dart';
import 'package:nest/core/usecase/usecase.dart';
import 'package:nest/core/common/entities/user.dart';
import 'package:nest/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;
  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}
