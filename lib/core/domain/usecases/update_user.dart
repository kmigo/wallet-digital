
import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../erros/failure.dart';

abstract class UpdateUserUsecase {
  Future<Either<Failure,void>> call(UserEntity userEntity);
}