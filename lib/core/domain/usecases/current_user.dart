
import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../erros/failure.dart';

abstract class CurrentUserUsecase {
  Future<Either<Failure,UserEntity>> call();
}