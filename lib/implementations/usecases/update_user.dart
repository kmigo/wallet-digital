

import 'package:dartz/dartz.dart';



import '../../core/domain/entities/user.dart';
import '../../core/domain/erros/failure.dart';

import '../../core/repository/authentication_repository.dart';
import '../../core/domain/usecases/update_user.dart';

class UpdateUserUsecaseImpl extends  UpdateUserUsecase {
  final AuthenticationRepository _repository;
  UpdateUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(UserEntity userEntity) async{
    return await _repository.updateUser(userEntity);
  }

}