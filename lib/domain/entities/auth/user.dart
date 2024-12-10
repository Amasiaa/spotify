// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String? fullName;
  final String email;

  const UserEntity({
    required this.userId,
    this.fullName,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, fullName, email];

  UserEntity copyWith({
    String? userId,
    String? fullName,
    String? email,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullName': fullName,
      'email': email,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['userId'] as String,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
