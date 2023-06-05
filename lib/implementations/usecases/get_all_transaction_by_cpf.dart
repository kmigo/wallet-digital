import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/usecases/get_transaction_by_uid.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class GetAllTransactionByCPFUsecaseImpl extends GetAllTransactionByCPFUsecase {
  final TransactionRepository _repository;
  GetAllTransactionByCPFUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, List<TransactionEntity>>> call(String cpf) async{
    return await _repository.getAllTransactionsByCPF(cpf);
  }

}