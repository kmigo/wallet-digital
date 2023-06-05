import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/usecases/current_user.dart';
import 'package:wallet_digital/core/domain/usecases/get_transaction_by_uid.dart';

class BlocExtract extends Cubit<BaseState>{
  final GetAllTransactionByCPFUsecase _allTransactionByCPF;
  final CurrentUserUsecase _currentUser;
  UserEntity? userEntity;
  BlocExtract(this._allTransactionByCPF,this._currentUser):super(StateIdle());


  getAllTransactions()async{
    emit(StateLoading());
    final resultUser = await _currentUser();
    resultUser.fold((l) => emit(StateError(message: l.message)), (user) async{
      userEntity = user;
      final resultTransactions = await _allTransactionByCPF(user.cpf);
      resultTransactions.fold((l) => emit(StateError(message: l.message)), (r) => emit(StateSuccess(data: r)));
    });
  }

}