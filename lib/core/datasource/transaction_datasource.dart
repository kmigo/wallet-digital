





import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/models/transaction.dart';

abstract class TransactionDatasource {
  Future<TransactionEntity> createTransaction(TransactionModel transaction);
  Future<List<TransactionEntity>> getAllTransactionsByCPF(String cpf);
  Future<void> updateTransaction(String transactionId, String notifcationId,TransactionModel transaction);
  Future<List<NotificationEntity>> getAllNotificationsByCPF(String cpf);
  Future<UserEntity> fetchUserByCpf(String cpf);
  
}