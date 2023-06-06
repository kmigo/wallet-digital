import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/core/domain/entities/notification.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';

import 'package:wallet_digital/core/domain/usecases/current_user.dart';
import 'package:wallet_digital/core/domain/usecases/get_all_notifications_by_cpf.dart';
import 'package:wallet_digital/core/domain/usecases/update_transaction.dart';
import 'package:wallet_digital/core/models/transaction.dart';

class BlocNotification extends Cubit<BaseState> {
  final CurrentUserUsecase _currentUserUsecase;
  final GetAllNotificationsByCPF _getAllNotificationsByCPF;
  final UpdateTransactionUsecase _updateTransactionUsecase;
  BlocNotification(this._currentUserUsecase,this._updateTransactionUsecase,this._getAllNotificationsByCPF):super(StateIdle());
  var _user = UserEntity.empty();
  loadNotifications()async{
    emit(StateLoading());
    final result = await _currentUserUsecase();
    result.fold((l) => emit(
      const StateError()
    ), (user) async{
      _user = user;
      final resultNotifications = await  _getAllNotificationsByCPF(user.cpf);
      resultNotifications.fold((l) => emit(const StateError()), (notifcations) => emit(StateSuccess(data: notifcations)));
    });
  }

  updateNotification(NotificationEntity notificationEntity)async{
    final transaction = TransactionModel(toId: _user.id,fromId: _user.id, amount: notificationEntity.amount, description: '', from: notificationEntity.from, to: notificationEntity.to, date: notificationEntity.expirationDate, plywood: true, fromCpf: notificationEntity.fromCpf,  toCpf: notificationEntity.toCpf, transactionType: notificationEntity.transactionType);
    emit(StateLoading());
    final result = await _updateTransactionUsecase(notificationEntity.transactionId,notificationEntity.id,transaction);
    result.fold((l) => emit(StateError(message:l.message)), (r) => loadNotifications());
  }
}