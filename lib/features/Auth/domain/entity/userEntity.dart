import 'package:equatable/equatable.dart';
import 'package:llearning/features/home/data/models/certificate_model.dart';
import 'dart:io';

import 'package:llearning/features/home/data/models/course_model.dart';
import 'package:llearning/features/home/data/models/user_quiz_result_model.dart';
class UserEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? profilePicture;
  final String bio;
  final List<CourseModel> enrolledCourses;
  final List<UserQuizResultModel> quizResults;
  final List<CertificateModel> certificates;

  const UserEntity({
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
