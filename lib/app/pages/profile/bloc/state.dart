// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:wallet_digital/core/domain/entities/user.dart';

enum ProfileStatus {
  loading,success,idle,error
}

class ProfileState extends Equatable {
  final UserEntity user;
  final ProfileStatus status;
 const ProfileState({
    required this.user,
    required this.status,
  });
  
  @override
  List<Object?> get props => [user,status];

  ProfileState copyWith({
    UserEntity? user,
    ProfileStatus? status,
  }) {
    return ProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
