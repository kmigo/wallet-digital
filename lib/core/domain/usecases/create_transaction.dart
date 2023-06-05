import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/models/transaction.dart';

abstract class CreateTransactionUsecase {
  Future<Either<Failure,TransactionEntity>> call(TransactionModel transaction);
}