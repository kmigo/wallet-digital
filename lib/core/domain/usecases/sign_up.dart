import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../erros/failure.dart';

abstract class SignUpUsecase {
  Future<Either<Failure,UserEntity>> call(UserEntity user, String password);
}