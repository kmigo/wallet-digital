// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
part '../../dtos/notification.dart';
class NotificationEntity extends Equatable {
  final String id;
  final double amount;
  final String expirationDate;
  final String fromCpf;
  final String toCpf;
  final String from;
  final String to;
  final String transactionType;
  final String transactionId;
  final bool plywood;
  final String createdAt;
  const NotificationEntity({
    required this.id,
    required this.amount,
    required this.from,
    required this.to,
    required this.expirationDate,
    required this.fromCpf,
    required this.toCpf,
    required this.transactionType,
    required this.transactionId,
    required this.plywood,
    required this.createdAt,
  });

  
  
  @override
  List<Object?> get props => [id,transactionId];
}
