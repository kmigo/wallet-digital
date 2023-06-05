import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../domain/entities/transactions.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel extends Equatable {
  final double amount;
  final String description;
  final String date;
  final String fromCpf;
  final String toCpf;
  final String transactionType;
  final String from;
  final String to;
  final bool plywood;
  final String toId;
  final String fromId;
  const TransactionModel({
    required this.amount,
    required this.description,
    required this.date,
    required this.fromCpf,
    required this.from,
    required this.toId,
    required this.fromId,
    required this.to,
    required this.toCpf,
    required this.plywood,
    required this.transactionType,
  });
 
 static TransactionModel empty({String type =  TransactionEnum.deposit}) =>  TransactionModel(from: '',to: '', toId: '',fromId: '', plywood: false, amount: 0.0, description: '', date: DateTime.now().toString(), fromCpf: '', toCpf: '', transactionType: type);



  TransactionModel copyWith({
    double? amount,
    String? description,
    String? date,
    String? fromCpf,
    String? toCpf,
    String? transactionType,
    String? from,
    String? to,
    String? toId,
    String? fromId,
    bool? plywood,
  }) {
    return TransactionModel(
      from: from ?? this.from,
      to: to ?? this.to,
      toId: toId ?? this.toId,
      fromId: fromId ?? this.fromId,
      plywood: plywood ?? this.plywood,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      fromCpf: fromCpf ?? this.fromCpf,
      toCpf: toCpf ?? this.toCpf,
      transactionType: transactionType ?? this.transactionType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'description': description,
      'date': date,
      'fromCpf': fromCpf,
      'toCpf': toCpf,
      'transactionType': transactionType,
      'from':from,
      'to':to,
      'plywood':plywood,
      'fromId':fromId,
      'toId':toId
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      from: map['from'],
      toId: map['toId'] ?? '',
      fromId: map['fromId'] ?? '',
      to: map['to'],
      plywood: map['plywood'],
      amount: map['amount'] as double,
      description: map['description'] as String,
      date: map['date'] as String,
      fromCpf: map['fromCpf'] as String,
      toCpf: map['toCpf'] as String,
      transactionType: map['transactionType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  List<Object?> get props => [toCpf, transactionType, amount,from,to,amount,description,date,fromCpf,fromCpf];
  }
