import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llearning/features/home/data/models/certificate_model.dart';
import 'package:llearning/features/home/data/models/course_model.dart';
import 'package:llearning/features/home/data/models/user_quiz_result_model.dart';

import '../../domain/entity/UserEntityforCourse.dart';


part 'user_entity_model.g.dart';

final userEntityModelProvider = Provider<UserModel>((ref) => UserModel.empty());

@JsonSerializable()
class UserModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? profilePicture;
  final String bio;
  final List<String> enrolledCourses;
  final List<String> quizResults;
  final List<String> certificates;

  const UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.profilePicture,
    this.bio = '',
    this.enrolledCourses = const [],
    this.quizResults = const [],
    this.certificates = const [],
  });

  UserModel.empty()
      : name = '',
        email = '',
        password = '',
        role = '',
        profilePicture = '',
        bio = '',

        enrolledCourses = const [],
        quizResults = const [],
        certificates = const [];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      role: json['role'] as String? ?? '',
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() => _$UserEntityModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      email: email, role: role, password: password, profilePicture:profilePicture ,
      enrolledCourses: enrolledCourses,
      quizResults: quizResults,
      certificates: certificates,
      // Add other fields if necessary in your UserEntity class
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
        name: entity.name,
        email: entity.email,
        password: entity.password,
        role: entity.role,
        profilePicture: entity.profilePicture,
        certificates: entity.certificates,
        quizResults: entity.quizResults,
        enrolledCourses: entity.enrolledCourses
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
    quizResults,
    certificates,
  ];
}

