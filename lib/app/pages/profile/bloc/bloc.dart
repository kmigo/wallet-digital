import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_digital/app/pages/profile/bloc/state.dart';
import 'package:wallet_digital/core/domain/entities/user.dart';
import 'package:wallet_digital/core/domain/usecases/current_user.dart';
import 'package:wallet_digital/core/domain/usecases/update_user.dart';


class BlocProfile extends Cubit<ProfileState> {
  final CurrentUserUsecase _currentUser;
  final UpdateUserUsecase _updateUser;
  BlocProfile(this._updateUser,this._currentUser):super(ProfileState(user: UserEntity.empty(), status: ProfileStatus.idle));

  loadUser()async{
    emit(state.copyWith(
      status: ProfileStatus.loading
    ));
    final result = await _currentUser();
    result.fold((l) => emit(state.copyWith(
      status: ProfileStatus.error
    )), (r) => emit(state.copyWith(
      user: r,
      status: ProfileStatus.success
    )));

  }

   updateUser()async{
   emit(state.copyWith(
    status: ProfileStatus.loading
   )) ;
   final result = await _updateUser(state.user);
   result.fold((l) => emit(state.copyWith(
    status: ProfileStatus.error
   )), (r) => emit(
    state.copyWith(status: ProfileStatus.success)
   ));
   }


  onChangedInfoUser(UserEntity userCopy){
    emit(state.copyWith(
      user: userCopy
    ));
  }

}