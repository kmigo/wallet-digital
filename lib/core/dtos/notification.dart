part of '../domain/entities/notification.dart';



extension NotificationDTO on NotificationEntity {


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'expirationDate': expirationDate,
      'fromCpf': fromCpf,
      'toCpf': toCpf,
      'transactionType': transactionType,
      'transactionId': transactionId,
      'plywood': plywood,
      'createdAt': createdAt,
      'from':from,
      'to':to,
    };
  }
  static NotificationEntity empty() => const NotificationEntity(id: '',from: '',to: '',
   amount: 0.0, expirationDate: '', fromCpf: '', toCpf: '', transactionType: '', transactionId: '', plywood: false, createdAt: '');

  static NotificationEntity fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      from: map['from'] ?? '',
      to: map['to']?? '',
      id: map['id'] ?? '',
      amount: map['amount'] ?? 0.0,
      expirationDate: map['expirationDate'] ?? '',
      fromCpf: map['fromCpf'] ?? '',
      toCpf: map['toCpf'] ?? '',
      transactionType: map['transactionType'] ?? '',
      transactionId: map['transactionId'] ?? '',
      plywood: map['plywood'] as bool,
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  static NotificationEntity fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

}