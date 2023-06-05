import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/pages/transfer/bloc/state.dart';
import 'package:wallet_digital/core/domain/entities/transactions.dart';
import 'package:wallet_digital/core/domain/usecases/create_transaction.dart';
import 'package:wallet_digital/core/domain/usecases/current_user.dart';
import 'package:wallet_digital/core/domain/usecases/fetch_user_by_cpf.dart';
import 'package:wallet_digital/core/models/transaction.dart';

class BlocTransfer extends Cubit<TransferState >{
  final CurrentUserUsecase _currentUserUsecase;
  final CreateTransactionUsecase _createTransactionUsecase;
  final FetchUserByCpf _userByCpf;

  BlocTransfer(this._currentUserUsecase, this._createTransactionUsecase, this._userByCpf):super(TransferState(status: TransferStatus.idle, transaction: TransactionModel.empty(type: TransactionEnum.transfer)));

  loadFromUser()async{
    emit(state.copyWith(
      status: TransferStatus.loading
    ));
    final result = await _currentUserUsecase();
    result.fold((l) => emit(state.copyWith(
      error: l.message,
      status: TransferStatus.error
    )), (r) => emit(state.copyWith(
      status: TransferStatus.success,
      fromUser: r,
      transaction: state.transaction.copyWith(
        from: r.firstName,
        fromCpf: r.cpf,
        fromId: r.id
      )
    )));
  }

  fetchUserByCpf(String cpf)async{
     emit(state.copyWith(
      status: TransferStatus.loading
    ));
    final result = await _userByCpf(cpf);
      result.fold((l) => emit(state.copyWith(
      error: l.message,
      status: TransferStatus.error
    )), (r) {
      if(state.fromUser == r){
        return emit(state.copyWith(
 status: TransferStatus.error,
 error: 'Voce não pode enviar dinheiro pra voce mesmo'
        ));
      }
      return emit(state.copyWith(
      status: TransferStatus.success,
      toUser: r,
      transaction: state.transaction.copyWith(
        to:r.firstName,
        toCpf: r.cpf,
        toId: r.id 
      )
    ));});
  }
  changeAmount(double amount){
    emit(state.copyWith(
      error: '',
      status: TransferStatus.success,
      transaction: state.transaction.copyWith(amount: amount)
    ));
  }

  makeTransfer()async{
        emit(state.copyWith(
      status: TransferStatus.loading
    ));
  final result = await _createTransactionUsecase(state.transaction.copyWith(
    date: DateTime.now().toString(),
    plywood: true
  ));
  result.fold((l) => emit(state.copyWith(
      error: l.message,
      status: TransferStatus.error
  )), (r) => emit(state.copyWith(
    status: TransferStatus.done
  )));
  }
}