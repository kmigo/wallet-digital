

import 'package:dartz/dartz.dart';


import '../../core/domain/entities/user.dart';
import '../../core/domain/erros/failure.dart';
import '../../core/domain/usecases/sign_up.dart';
import '../../core/repository/authentication_repository.dart';


class SignUpUsecaseImpl extends  SignUpUsecase {
  final AuthenticationRepository _repository;

  SignUpUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserEntity user, String password) async{
    return await _repository.signUp(user, password);
  }
}