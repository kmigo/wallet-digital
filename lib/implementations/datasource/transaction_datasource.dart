
import 'package:firebase_database/firebase_database.dart';
import 'package:wallet_digital/core/datasource/transaction_datasource.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import '/utils/constants.dart' as constants;
class TransactionDatasourceImpl extends TransactionDatasource {
  final _db = FirebaseDatabase.instance;

  @override
  Future<TransactionEntity> createTransaction(TransactionModel transaction) async{
    await _trasferBalance(transaction);
      DatabaseReference idRef = _db.ref().child(constants.transactions).push();
        final Map<String, dynamic> data = {'createdAt':DateTime.now().toString(),
        'id':idRef.key
        };
        data.addAll(transaction.toMap());
      await idRef.set(data);
      DatabaseReference idRefNoti = _db.ref().child(constants.notifications).push();
      final Map<String, dynamic> dataNoti = {'createdAt':DateTime.now().toString(),
        'id':idRefNoti.key,
        'transactionId':idRef.key,
        'expirationDate':transaction.date

        };
         final transactionEntity = TransactionDTO.fromMap(data);
        dataNoti.addAll(transactionEntity.toMap());
        final notificationEntity = NotificationDTO.fromMap(dataNoti);
        await idRefNoti.set(notificationEntity.toMap());
      return transactionEntity; 

  }

  @override
  Future<List<TransactionEntity>> getAllTransactionsByCPF(String cpf) async {

    final ref = _db.ref().child(constants.transactions);
    final queryOne = ref.orderByChild('toCpf').equalTo(cpf);
    final queryTwo = ref.orderByChild('fromCpf').equalTo(cpf);
    var results = <DataSnapshot>[];
    await queryOne.get().then((document) {
      for(var snap in document.children){

        results.add(snap);
      }
    });
     await queryTwo.get().then((document) {
      for(var snap in document.children){

        results.add(snap);
      }
    });
    
    return results.map<TransactionEntity>((e) => TransactionDTO.fromMap(e.value as Map<String, dynamic>)).toSet().toList();

  }

  @override
  Future<void> updateTransaction(String transactionId, String notifcationId,TransactionModel transaction) async{
    final map = transaction.toMap();
    map.removeWhere((key, value) => value.toString().isEmpty);
    await _db.ref().child(constants.transactions).child(transactionId).update(map);
    DatabaseReference idRef = _db.ref().child(constants.notifications).child(notifcationId);
    final data = {
      'id':idRef.key,
      'createdAt':DateTime.now().toString(),
      'transactionId':transactionId,
    };
    map.addAll(data);
    final notification = NotificationDTO.fromMap(map);
    await idRef.update(notification.toMap());
    await _compensate(transaction);
  }
  
  @override
  Future<List<NotificationEntity>> getAllNotificationsByCPF(String cpf) async{
     final ref = _db.ref().child(constants.notifications);
    final queryOne = ref.orderByChild('toCpf').equalTo(cpf);
    final queryTwo = ref.orderByChild('fromCpf').equalTo(cpf);
    var results = <DataSnapshot>[];
    await queryOne.get().then((document) {
      for(var snap in document.children){

        results.add(snap);
      }
    });
     await queryTwo.get().then((document) {
      for(var snap in document.children){

        results.add(snap);
      }
    });
    
    return results.map<NotificationEntity>((e) => NotificationDTO.fromMap(e.value as Map<String, dynamic>)).toSet().toList();
  }
  _trasferBalance(TransactionModel transaction)async {
    if(transaction.transactionType != TransactionEnum.transfer)return;
    final toDocument = await _db.ref(constants.user).child(transaction.toId).get();
    final fromDocument = await _db.ref(constants.user).child(transaction.fromId).get();
    final toUser = UserDTO.fromMap(toDocument.value as Map<String, dynamic>);
    final fromUser =UserDTO.fromMap(fromDocument.value as  Map<String, dynamic>);

    if(transaction.amount > fromUser.balance){
      throw const Failure(message: 'Saldo insuficiente');
    }
    await _db.ref(constants.user).child(fromUser.id).update({'balance':fromUser.balance - transaction.amount});
    await _db.ref(constants.user).child(toUser.id).update({'balance':toUser.balance + transaction.amount});

  }
  _compensate(TransactionModel transaction)async{
    final toDocument = await _db.ref(constants.user).child(transaction.toId).get();
    final toUser = UserDTO.fromMap(toDocument.value as Map<String, dynamic>);
    await _db.ref(constants.user).child(toUser.id).update({'balance':toUser.balance+transaction.amount});
  }
  
  @override
  Future<UserEntity> fetchUserByCpf(String cpf) async{
   final docs = await  _db.ref(constants.user).orderByChild('cpf').equalTo(cpf).get();
  final entities = docs.children.map((e) => UserDTO.fromMap(e.value as Map<String,dynamic>)).toList();
  if(entities.isEmpty) throw const Failure(message: 'Nenhum usuario encontrado');
  return entities.first;
  }
  
  

}