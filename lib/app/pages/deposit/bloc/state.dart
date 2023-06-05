// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:wallet_digital/core/models/transaction.dart';

enum DepositStatus {loading,success,idle,error}

class DepositState extends Equatable {
  final DepositStatus status;
  final TransactionModel transaction;
  const  DepositState({
    required this.status,
    required this.transaction ,
  });
  
  @override
  List<Object?> get props => [status,transaction];


  DepositState copyWith({
    DepositStatus? status,
    TransactionModel? transaction,
  }) {
    return DepositState(
      status: status ?? this.status,
      transaction: transaction ?? this.transaction,
    );
  }

  canExecuteTransaction(){

    return transaction.amount >= 20 && transaction.amount <= 3000 && transaction.date.isNotEmpty;
  }
}
