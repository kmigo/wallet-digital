// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'dart:convert';

import 'package:equatable/equatable.dart';

part '../../dtos/user.dart';
class UserEntity extends Equatable {
  final String id;

  final String username;
  final String firstName;

  final String image;
  final String cpf;
  final String zipCode;
  final String city;
  final String neighborhood;
  final String street;
  final String houseNumber;
  final String phoneNumber;
  final double balance;
  const UserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.cpf,
    required this.zipCode,
    required this.city,
    required this.balance,
    required this.image,
    required this.neighborhood,
    required this.street,
    required this.houseNumber,
    required this.phoneNumber,
  });

  static UserEntity empty() => const UserEntity(id: '', username: '',image: '', balance: 0.0, firstName: '',  cpf: '', zipCode: '', city: '', neighborhood: '', street: '', houseNumber: '', phoneNumber: '',);
  
  @override
  List<Object?> get props => [firstName,id,username, image,cpf,zipCode,city,neighborhood,street,houseNumber,balance
  ,phoneNumber
  ];


  UserEntity copyWith({
    String? id,
    String? username,
    String? firstName,
    String? image,
    String? cpf,
    String? zipCode,
    String? city,
    String? neighborhood,
    String? street,
    String? houseNumber,
    String? phoneNumber,
    double? balance,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      image: image ?? this.image,
      cpf: cpf ?? this.cpf,
      balance: balance ?? this.balance,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
