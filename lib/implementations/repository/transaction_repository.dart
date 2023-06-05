import 'package:wallet_digital/core/datasource/transaction_datasource.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/models/transaction.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionDatasource _datasource;
  TransactionRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, TransactionEntity>> createTransaction(TransactionModel transaction) async {
    try{
      return Right(await _datasource.createTransaction(transaction));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactionsByCPF(String cpf) async{
     try{
      return Right(await _datasource.getAllTransactionsByCPF(cpf));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return const Left(Failure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(String transactionId,String notifcationId, TransactionModel transaction) async{
    try{
      return Right(await _datasource.updateTransaction(transactionId,notifcationId,transaction));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return const Left(Failure());
    }
  }
  
  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotificationsByCPF(String cpf) async {
    try{
      return Right(await _datasource.getAllNotificationsByCPF(cpf));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return const Left(Failure());
    }
  }



  @override
  Future<Either<Failure, UserEntity>> fetchUserByCpf(String cpf) async{
    try{
      return Right(await _datasource.fetchUserByCpf(cpf));
    }on Failure catch(e){
      return Left(e);
    }catch(e){
      return const Left(genericError);
    }
  }

}