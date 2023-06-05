import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/pages/deposit/bloc/state.dart';
import 'package:wallet_digital/core/domain/usecases/create_transaction.dart';
import 'package:wallet_digital/core/domain/usecases/current_user.dart';
import 'package:wallet_digital/core/models/transaction.dart';

class BlocDeposit extends Cubit<DepositState>{
  final CurrentUserUsecase _currentUser;
  final CreateTransactionUsecase _createTransaction;
  BlocDeposit(this._currentUser,this._createTransaction):super(DepositState( status: DepositStatus.idle, transaction: TransactionModel.empty()));
  
  selectDate(DateTime date){
    emit(state.copyWith(
      transaction: state.transaction.copyWith(date: date.toString())
    ));
  }

  setAmount(double amount){
    emit(state.copyWith(transaction: state.transaction.copyWith(amount: amount)));
  }

  setDescription(String description){
     emit(state.copyWith(transaction: state.transaction.copyWith(description: description)));
  }

  createTransaction()async {
    emit(state.copyWith(status: DepositStatus.loading));
    final resultUser = await _currentUser();
    resultUser.fold((errorUser) => emit(state.copyWith(
      status: DepositStatus.error
    )), (user) async{
      final resultTransaction = await _createTransaction(state.transaction.copyWith(
        from: user.firstName,
        fromCpf: user.cpf,
        to: user.firstName,
        toCpf: user.cpf

      ));
    resultTransaction.fold((l) => emit(state.copyWith(
      status: DepositStatus.error
    )), (r) => emit(state.copyWith(
      status: DepositStatus.success
    )));
    });
  }

}