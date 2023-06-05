// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';

class TransactionsByDate extends Equatable{
  final String date;
  final List<TransactionEntity> transactions;
  const TransactionsByDate({
    required this.date,
    required this.transactions,
  });
  
  @override
  List<Object?> get props => [date];
}
