import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/usecases/fetch_user_by_cpf.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class FetchUserByCpfImpl extends FetchUserByCpf {
  final TransactionRepository _repository;

  FetchUserByCpfImpl(this._repository);
  @override
  Future<Either<Failure, UserEntity>> call(String cpf) async{
    return await _repository.fetchUserByCpf(cpf);
  }

}