


import '../domain/entities/user.dart';

abstract class AuthenticationDatasource {
  Future<UserEntity> signIn(String username, String password);
  Future<UserEntity> signUp(UserEntity user, String password);
  Future<void> signOut();
  Future<UserEntity?> currentUser();
  Future<void> updateUser(UserEntity userEntity);
  Stream<UserEntity> realTimeUser();
}