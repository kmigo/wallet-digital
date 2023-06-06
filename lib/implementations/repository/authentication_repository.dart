import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wallet_digital/helpers/analytics.dart';

import '../../core/datasource/authentication_user.dart';
import '../../core/domain/entities/user.dart';
import '../../core/domain/erros/failure.dart';
import '../../core/repository/authentication_repository.dart';


class AutheticationRepositoryImpl extends AuthenticationRepository {
   final _controller = StreamController<AuthenticationStatus>();
     StreamSubscription<UserEntity>? _streamSubscription;
   final AuthenticationDatasource _datasource;
  AutheticationRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
   try{
      final result = await _datasource.currentUser();
      if(result == null){
        _streamSubscription?.cancel();
        _controller.add(AuthenticationStatus(result, StatusAuthentication.unauthentication));
        return const Left(Failure());
      }else{
        _listenUser();
        _controller.add(AuthenticationStatus(result, StatusAuthentication.authentication));
      }
      
      return Right(result);
   }on Failure catch(e){
    _streamSubscription?.cancel();
    _controller.add(const AuthenticationStatus(null, StatusAuthentication.error));
    return  Left(e);
   }catch(e){
    _streamSubscription?.cancel();
    _controller.add(const AuthenticationStatus(null, StatusAuthentication.error));
      return const Left(genericError);
   }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(String username, String password) async{
    try{
   final user = await _datasource.signIn(username,password);
      _controller.add( AuthenticationStatus(user, StatusAuthentication.signin));
      

    
  _listenUser();
      return  Right(user);
   }on FirebaseAuthException catch(e){
    _streamSubscription?.cancel();
      final message = _getFirebaseAuthErrorMessage(e.code);
      return  Left(Failure(message: message));
   }on Failure catch(e){
    _streamSubscription?.cancel();
    _controller.add(const AuthenticationStatus(null, StatusAuthentication.error));
    return  Left(e);
   }catch(e){
      return const Left(genericError);
   }
  }

  @override
  Future<Either<Failure, void>> signOut() async{
    try{
      _streamSubscription?.cancel();
      final result = await _datasource.signOut();
      _controller.add(const AuthenticationStatus(null, StatusAuthentication.signOut));
      return Right(result);
   } on Failure catch(e){
    _streamSubscription?.cancel();
    _controller.add(const AuthenticationStatus(null, StatusAuthentication.error));
    return  Left(e);
   }catch(e){
    _streamSubscription?.cancel();
      return const Left(genericError);
   }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(UserEntity user, String password) async{
    try{
      final result = await _datasource.signUp(user,password);
      _controller.add(AuthenticationStatus(result, StatusAuthentication.signup));
      
      _listenUser();
      return Right(result);
   }on FirebaseAuthException catch(e){
    _streamSubscription?.cancel();
    final message = _getFirebaseAuthErrorMessage(e.code);
    final idref =FirebaseDatabase.instance.ref('errors').push();
    idref.set({
      'event':'signUp-error-firebase',
       'data':user.toMap(),
        'error':e.toString(),
        'message':message
    });
      
      await HelperAnalytcs.sendAnalyticsEvent('signUp-error-firebase',{
        'data':user.toMap(),
        'error':e.toString(),
        'message':message
      });
      return  Left(Failure(message: e.toString()));
   }on Failure catch(e){
    _streamSubscription?.cancel();
    return  Left(e);
   }catch(e){
    _streamSubscription?.cancel();
     return const Left(genericError);
   }
  }
    _listenUser()async{
      _streamSubscription?.cancel();
    final userStream =  _datasource.realTimeUser();
   _streamSubscription =  userStream.listen((event) { 

      _controller.add(AuthenticationStatus(event, StatusAuthentication.authentication));
    });
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 2));
    yield  const AuthenticationStatus(null, StatusAuthentication.unknow);
    yield* _controller.stream;
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity) async {
   try{
      final result = await _datasource.updateUser(userEntity);
      return Right(result);
   }on Failure catch(e){
    return  Left(e);
   }catch(e){
     return const Left(genericError);
   }
  }


    String _getFirebaseAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'email-already-in-use':
      return 'O email já está sendo usado por outra conta.';
    case 'invalid-email':
      return 'O email fornecido é inválido.';
    case 'operation-not-allowed':
      return 'O método de autenticação não está habilitado.';
    case 'weak-password':
      return 'A senha é muito fraca.';
    case 'user-not-found':
      return 'Não há usuário com o email fornecido.';
    case 'user-disabled':
      return 'O usuário foi desativado.';
    case 'wrong-password':
      return 'A senha está incorreta.';
    case 'too-many-requests':
      return 'Muitas tentativas de login. Tente novamente mais tarde.';
    default:
      return 'Ocorreu um erro desconhecido.';
  }
  }

  
 

}