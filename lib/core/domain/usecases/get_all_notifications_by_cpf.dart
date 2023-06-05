import 'package:dartz/dartz.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';

abstract class GetAllNotificationsByCPF {
  Future<Either<Failure,List<NotificationEntity>>> call(String cpf);
}