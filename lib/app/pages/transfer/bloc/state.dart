// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/models/transaction.dart';

enum TransferStatus {idle,error,loading,success,done}

class TransferState extends Equatable {
  final UserEntity? toUser;
  final UserEntity? fromUser;
  final TransferStatus status;
  final TransactionModel transaction;
  final String? error;
  const TransferState({
    this.toUser,
    this.fromUser,
    this.error,
    required this.status,
    required this.transaction
  });
  
  @override
  List<Object?> get props => [toUser,error,fromUser,status,transaction];


  TransferState copyWith({
    UserEntity? toUser,
    UserEntity? fromUser,
    TransferStatus? status,
    TransactionModel? transaction,
    String? error,
  }) {
    return TransferState(
      toUser: toUser ?? this.toUser,
      fromUser: fromUser ?? this.fromUser,
      status: status ?? this.status,
      transaction: transaction ?? this.transaction,
      error: error ?? this.error,
    );
  }

  validate(){
    return transaction.amount >=20 && transaction.amount <= 3000 && toUser != null && fromUser != null;
  }
}
