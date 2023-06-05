

import 'package:dartz/dartz.dart';



import '../../core/domain/erros/failure.dart';
import '../../core/domain/usecases/sign_out.dart';
import '../../core/repository/authentication_repository.dart';


class SignOutUsecaseImpl extends SignOutUsecase {
  final AuthenticationRepository _repository;
  SignOutUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call() async {
    return await _repository.signOut();
  }
}