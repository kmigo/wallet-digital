import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/usecases/update_transaction.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class UpdateTransactionUsecaseImpl extends UpdateTransactionUsecase {
  final TransactionRepository _repository;
  UpdateTransactionUsecaseImpl(this._repository);
  @override
  Future<Either<Failure, void>> call(String transactionId,String notifcationId, TransactionModel model)async {
    return await _repository.updateTransaction(transactionId, notifcationId, model);
  }

}