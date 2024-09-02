import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llearning/features/home/data/models/certificate_model.dart';
import 'package:llearning/features/home/data/models/course_model.dart';
import 'package:llearning/features/home/data/models/user_quiz_result_model.dart';
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
  final List<CourseModel> enrolledCourses;
  final List<UserQuizResultModel> quizResults;
  final List<CertificateModel> certificates;

  const UserEntityModel({
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

  UserEntityModel.empty()
      : name = '',
        email = '',
        password = '',
        role = '',
        profilePicture = '',
        bio = '',

        enrolledCourses = const [],
        quizResults = const [],
        certificates = const [];

  factory UserEntityModel.fromJson(Map<String, dynamic> json) {
    return UserEntityModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      role: json['role'] as String? ?? '',
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String? ?? '',
      enrolledCourses: (json['enrolled_courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      quizResults: (json['quiz_results'] as List<dynamic>?)
          ?.map((e) => UserQuizResultModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      certificates: (json['certificates'] as List<dynamic>?)
          ?.map((e) => CertificateModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
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

  static UserEntityModel fromEntity(UserEntity entity) {
    return UserEntityModel(
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

