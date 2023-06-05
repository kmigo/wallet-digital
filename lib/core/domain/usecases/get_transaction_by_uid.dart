import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';

abstract class GetAllTransactionByCPFUsecase {
  Future<Either<Failure,List<TransactionEntity>>> call(String cpf);
}