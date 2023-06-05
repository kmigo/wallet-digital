import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/models/transaction.dart';

abstract class UpdateTransactionUsecase {
  Future<Either<Failure,void>> call(String transactionId,String notifcationId,TransactionModel model);
}