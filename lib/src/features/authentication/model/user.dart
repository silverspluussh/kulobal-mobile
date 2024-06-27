// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Usermodel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? location;
  final String? password;
  final String? phoneNumber;
  Usermodel({
    this.firstName,
    this.lastName,
    this.email,
    this.location,
    this.password,
    this.phoneNumber,
  });

  Usermodel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? location,
    String? password,
    String? phoneNumber,
  }) {
    return Usermodel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      location: location ?? this.location,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'location': location,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) =>
      Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);
}

final userProvider = StateProvider<Usermodel>((ref) {
  return Usermodel();
});
