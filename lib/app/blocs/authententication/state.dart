
part of 'bloc.dart';
class AutheticationState extends Equatable {
  final AuthenticationStatus status;
  final UserEntity? user;


  const AutheticationState({required this.status, this.user});
  @override
  List<Object?> get props => [user,status];

  AutheticationState copyWith({
    AuthenticationStatus? status,
    UserEntity? user,

  }) {
    return AutheticationState(
      status: status ?? this.status,
      user: user ?? this.user,
     
    );
  }
}
