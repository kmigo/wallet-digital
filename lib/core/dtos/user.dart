

part of '../domain/entities/user.dart';

extension UserDTO on UserEntity {
  
 Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'first_name': firstName,
      'balance':balance,
      'cpf': cpf,
      'image':image,
      'zipCode': zipCode,
      'city': city,
      'neighborhood': neighborhood,
      'street': street,
      'house_number': houseNumber,
      'mobile_phone': phoneNumber,
    };
  }


 static UserEntity  fromMap(Map<String, dynamic> ?map) {
    return UserEntity(
      id: map?['id'] ?? '',
      username: map?['username'] ?? '',
      firstName: map?['first_name'] ?? '',
      image: map?['image'] ?? '' ,
      cpf: map?['cpf'] ?? '',
      zipCode: map?['zip_code'] ?? '',
      balance: (map?['balance'] ?? 0.0)+ 0.0,
      city: map?['city'] ?? '',
      neighborhood: map?['neighborhood'] ?? '',
      street: map?['street'] ?? '',
      houseNumber: map?['house_number'] ?? '00',
      phoneNumber: map?['mobile_phone']?? ''
    );
  }

  String toJson() => json.encode(toMap());

static fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);
}
