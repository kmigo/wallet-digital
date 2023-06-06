import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/user.dart';
import '../domain/erros/failure.dart';
enum StatusAuthentication {
  unknow,
  authentication,
  signup,
  signin,
  unauthentication,
  signOut,
  error
}

class AuthenticationStatus  extends Equatable {
  final UserEntity? user;
  final StatusAuthentication status;
  const AuthenticationStatus(this.user, this.status);
  
  @override
  List<Object?> get props => [user,status];
  AuthenticationStatus copyWith({
     UserEntity? user,
   StatusAuthentication? status
  }){
    return AuthenticationStatus(user ?? this.user, status ?? this.status);
  }
  
}


abstract class AuthenticationRepository {
  Future<Either<Failure,UserEntity>> signIn(String username, String password);
  Future<Either<Failure,UserEntity>> signUp(UserEntity user, String password);
  Future<Either<Failure,void>> signOut();
  Future<Either<Failure,UserEntity>> currentUser();
  Future<Either<Failure,void>> updateUser(UserEntity userEntity);
  Stream<AuthenticationStatus> get status;
}