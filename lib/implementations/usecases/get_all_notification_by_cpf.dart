import 'package:wallet_digital/core/domain/erros/failure.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/usecases/get_all_notifications_by_cpf.dart';
import 'package:wallet_digital/core/repository/transaction_repository.dart';

class GetAllNotificationsByCPFImpl extends GetAllNotificationsByCPF {
  final TransactionRepository _repository;

  GetAllNotificationsByCPFImpl(this._repository);
  @override
  Future<Either<Failure, List<NotificationEntity>>> call(String cpf) async{
    return await _repository.getAllNotificationsByCPF(cpf);
  }

}