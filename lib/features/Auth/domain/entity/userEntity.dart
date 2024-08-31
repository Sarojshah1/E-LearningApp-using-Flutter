import 'package:equatable/equatable.dart';
import 'dart:io';
class UserEntity extends Equatable {
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

  const UserEntity({
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
