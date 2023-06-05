part of '../domain/entities/transactions.dart';

extension TransactionDTO on TransactionEntity {
 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'description': description,
      'expirationDate': expirationDate,
      'fromCpf': fromCpf,
      'toCpf': toCpf,
      'transactionType': transactionType,
      'plywood': plywood,
      'createdAt': createdAt,
      'from':from,
      'to':to,
      'toId':toId,
      'fromId':fromId
    };
  }
  static TransactionEntity fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      from: map['from']?? '',
      to: map['to']?? '',
      toId: map['toId'] ?? '',
      fromId: map['fromId']?? '',
      id: map['id'] ?? '',
      amount: map['amount'] ?? '',
      description: map['description'] ?? '',
      expirationDate: map['date'] ?? '',
      fromCpf: map['fromCpf'] ?? '',
      toCpf: map['toCpf'] ?? '',
      transactionType: map['transactionType'] ?? '',
      plywood: map['plywood'] ?? false,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static  TransactionEntity fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
  
}