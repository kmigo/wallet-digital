import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/usecases/sign_in.dart';
import '/app/blocs/state_general.dart';

class BlocSignIn extends Cubit<BaseState> {
  final SignInUsecase _signInUsecase;
  BlocSignIn(SignInUsecase signInUsecase) : _signInUsecase=signInUsecase, super(StateIdle());
  login(String username,String password) async{
    emit(StateLoading());
    final result = await _signInUsecase(username,password);
    result.fold((l) {
      emit(StateError(message: l.message));
    }, (r) {
      emit(const StateSuccess());
    });
  }

}