import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';

import '../domain/entities/transactions.dart';
import '../models/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionEntity>> createTransaction(TransactionModel transaction);
  Future<Either<Failure,List<TransactionEntity>>> getAllTransactionsByCPF(String cpf);
  Future<Either<Failure,void>> updateTransaction(String transactionId, String notifcationId,TransactionModel transaction);
  Future<Either<Failure,List<NotificationEntity>>> getAllNotificationsByCPF(String cpf);
  Future<Either<Failure,UserEntity>> fetchUserByCpf(String cpf);
}