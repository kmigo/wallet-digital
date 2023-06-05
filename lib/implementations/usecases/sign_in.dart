import 'package:dartz/dartz.dart';



import '../../core/domain/entities/user.dart';
import '../../core/domain/erros/failure.dart';
import '../../core/domain/usecases/sign_in.dart';
import '../../core/repository/authentication_repository.dart';


class SignInUsecaseImpl extends SignInUsecase {
  final AuthenticationRepository _repository;

  SignInUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(
      String username, String password) async {
    return await _repository.signIn(username, password);
  }
}
