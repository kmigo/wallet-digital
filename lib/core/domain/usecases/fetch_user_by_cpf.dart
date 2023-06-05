import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';

abstract class FetchUserByCpf {
  Future<Either<Failure,UserEntity>> call(String cpf);
}