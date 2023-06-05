
// ignore_for_file: unused_field

import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;
import '../../../core/domain/entities/user.dart';
import '../../../core/domain/usecases/current_user.dart';
import '../../../core/domain/usecases/sign_out.dart';
import '../../../core/repository/authentication_repository.dart';



part 'state.dart';
part 'event.dart';

class AutheticationBloc extends Bloc<AuthenticationEvent, AutheticationState> {
  late StreamSubscription<AuthenticationStatus> _controller;
  final CurrentUserUsecase _currentUserUsecase;
  final SignOutUsecase _signOutUsecase;
  AutheticationBloc(
      {required Stream<AuthenticationStatus> controller,
      required SignOutUsecase signOutUsecase,
      required CurrentUserUsecase currentUserUsecase,})
      : _signOutUsecase = signOutUsecase,
        _currentUserUsecase = currentUserUsecase,
        super(const AutheticationState(
            status: AuthenticationStatus(null, StatusAuthentication.unknow))) {
    on<AuthenticationSignOutEvent>(_signOut);
    on<AuthenticationChangeStatusEvent>(_changeStatus);
    on<AuthenticationCurrentUserEvent>(_isCurrentUser);

    _controller = controller
        .listen((status) {
          dev.log("status: $status");
          add(AuthenticationChangeStatusEvent(status));
          });
  }

  Future<void> _signOut(AuthenticationSignOutEvent event,
      Emitter<AutheticationState> emit) async {

        await _signOutUsecase();

     
      }

  Future<void> _changeStatus(AuthenticationChangeStatusEvent event,
      Emitter<AutheticationState> emit) async {
        
        emit(state.copyWith(status: event.status));
         
      
      }

  Future<void> _isCurrentUser(AuthenticationCurrentUserEvent event,
      Emitter<AutheticationState> emit) async {

        await _currentUserUsecase();

      }

 
}
