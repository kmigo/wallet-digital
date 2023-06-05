import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/blocs/state_general.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/usecases/sign_up.dart';

class BlocSignUp extends Cubit<BaseState>{
  final SignUpUsecase _signUp;
  BlocSignUp({required SignUpUsecase signUp}): _signUp = signUp, super(StateIdle());
  register(UserEntity userEntity,String password)async{
    emit(StateLoading());
    final result = await _signUp(userEntity,password);
    result.fold((l) => emit(StateError(message: l.message)), (r) => StateSuccess(data: r));
  }
}