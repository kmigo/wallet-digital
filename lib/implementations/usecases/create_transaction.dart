import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/usecases/create_transaction.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class CreateTransactionUsecaseImpl extends CreateTransactionUsecase {
  final TransactionRepository _repository;
  CreateTransactionUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, TransactionEntity>> call(TransactionModel transaction) async{
    return await _repository.createTransaction(transaction);
  }

}