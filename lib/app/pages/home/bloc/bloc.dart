import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_digital/app/pages/home/bloc/state.dart';
import 'package:wallet_digital/core/domain/usecases/sign_out.dart';

class BlocHome extends Cubit<HomeState>{
  final SignOutUsecase _signOut;
  BlocHome({required SignOutUsecase signOut}):_signOut=signOut, super(const HomeState());

  signOut()async{
    await _signOut();
  }

  visible(){
    emit(state.copyWith(visible: !state.visible));
  }

  onChangePage(int page){
    emit(state.copyWith(page: page));
  }

}