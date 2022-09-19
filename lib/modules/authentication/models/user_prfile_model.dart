import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final String email;
  const UserProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
  });

  @override
  List<Object> get props => [id, name, image, email];

  UserProfileModel copyWith({
    int? id,
    String? name,
    String? image,
    String? email,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'avatar': image});
    result.addAll({'email': email});

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['avatar'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, avatar: $image, email: $email)';
  }
}
