import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/Entity/UserEntity.dart';

part 'user_entity_model.g.dart';

final userEntityModelProvider = Provider<UserEntityModel>((ref) => UserEntityModel.empty());

@JsonSerializable()
class UserEntityModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? profilePicture;
  final String bio;
  final List<String> enrolledCourses;
  final List<String> payments;
  final List<String> blogPosts;
  final List<String> quizResults;
  final List<String> reviews;
  final List<String> certificates;

  const UserEntityModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
   this.profilePicture,
    this.bio = '',
    this.enrolledCourses = const [],
    this.payments = const [],
    this.blogPosts = const [],
    this.quizResults = const [],
    this.reviews = const [],
    this.certificates = const [],
  });

  UserEntityModel.empty()
      : name = '',
        email = '',
        password = '',
        role = '',
        profilePicture = '',
        bio = '',

        enrolledCourses = const [],
        payments = const [],
        blogPosts = const [],
        quizResults = const [],
        reviews = const [],
        certificates = const [];

  factory UserEntityModel.fromJson(Map<String, dynamic> json) => _$UserEntityModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
       name: name,
      email: email, role: role, password: password, profilePicture:profilePicture ,
      // Add other fields if necessary in your UserEntity class
    );
  }

  static UserEntityModel fromEntity(UserEntity entity) {
    return UserEntityModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      role: entity.role,
      profilePicture: '', // Set this if it's available in UserEntity
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    role,
    profilePicture,
    bio,
    enrolledCourses,
    payments,
    blogPosts,
    quizResults,
    reviews,
    certificates,
  ];
}