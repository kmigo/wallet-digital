
// ignore_for_file: deprecated_member_use_from_same_package, unused_field



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet_digital/core/domain/erros/failure.dart';
import '/utils/constants.dart' as constants;
import '../../core/datasource/authentication_user.dart';
import '../../core/domain/entities/user.dart';


class AuthenticationDatasourceImpl extends AuthenticationDatasource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;

  AuthenticationDatasourceImpl(){
     if (!kIsWeb) {
      _db.setPersistenceEnabled(true);
      _db.setPersistenceCacheSizeBytes(10000000);
    }
  }
  
  @override
  Future<UserEntity?> currentUser() async {
    final user = _auth.currentUser;
    if(user == null)return null;
    final userJson = await _db.ref(constants.user).child(user.uid).get();
    return UserDTO.fromMap(userJson.value as Map<String, dynamic>? );
  }
  
  @override
  Future<UserEntity> signIn(String username, String password)  async {
    final userCredentials = await _auth.signInWithEmailAndPassword(email: username, password: password);
     final id =   userCredentials.user?.uid;
     if(id == null){
      throw const Failure(message: 'Erro desconhecido');
     }
     final userData = await _db.ref(constants.user).child(id).get();
    final user = UserDTO.fromMap(userData.value as Map<String, dynamic>);
    return user;
  }
  
  @override
  Future<void> signOut() async{

    await _auth.signOut();
  }
  
  @override
  Future<UserEntity> signUp(UserEntity user, String password) async{
    final cpfs = await  _db.ref(constants.user).orderByChild('cpf').equalTo(user.cpf).get();  

    if(cpfs.children.isNotEmpty) throw const Failure(message: 'Cpf já existe');
    final credentials =await _auth.createUserWithEmailAndPassword(email: user.username, password: password);
    final id=  credentials.user?.uid;
    if(id == null){
      throw const Failure(message: 'Erro desconhecido');
    }
    final newUser =user.copyWith(id: id);
    await _db.ref(constants.user).child(id).set(newUser.toMap());
    return newUser;
  }
  
  @override
  Future<void> updateUser(UserEntity userEntity) async{
    await _db.ref(constants.user).child(userEntity.id).set(userEntity.toMap());
  }
  @override
  Stream<UserEntity> realTimeUser() {
    final user = _auth.currentUser;
    final id=  user?.uid;
    return _db.ref().child(constants.user).child(id!).onValue.map<UserEntity>((event) => UserDTO.fromMap(event.snapshot.value as Map<String,dynamic>)).asBroadcastStream();
  }
 
}
