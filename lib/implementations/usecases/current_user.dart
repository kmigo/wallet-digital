import 'package:dartz/dartz.dart';



import '../../core/domain/entities/user.dart';
import '../../core/domain/erros/failure.dart';
import '../../core/domain/usecases/current_user.dart';
import '../../core/repository/authentication_repository.dart';


class CurrentUserUsecaseImpl extends CurrentUserUsecase {
  final AuthenticationRepository _repository;
  CurrentUserUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.currentUser();
  }
}
