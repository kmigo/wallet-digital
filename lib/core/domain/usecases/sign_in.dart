
import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../erros/failure.dart';

abstract class SignInUsecase {
  Future<Either<Failure,UserEntity>> call(String username, String password);
}