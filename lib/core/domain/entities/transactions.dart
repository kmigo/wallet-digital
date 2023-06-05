// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

part '../../dtos/transaction.dart';
class TransactionEnum {
  static const deposit= "DEPOSIT";
  static const transfer = "TRANSFER";

  static const _map = {
    deposit:"DEPÓSITO",
    transfer:"TRANSFERÊNCIA"
  };

  static name(String key){
    assert(_map.keys.map((e) => e).toList().contains(key));
    return _map[key];
  }


}

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String description;
  final String expirationDate;
  final String fromCpf;
  final String toCpf;
  final String from;
  final String to;
  final String toId;
  final String fromId;
  final String transactionType;
  final bool plywood;
  final String createdAt;
  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.from,
    required this.to,
    required this.toId,
    required this.fromId,
    required this.expirationDate,
    required this.plywood,
    required this.fromCpf,
    required this.createdAt,
    required this.toCpf,
    required this.transactionType,
  });
 
  @override
  List<Object?> get props => [id];

}
