import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? profilePicture;
  final String bio;
  final List<String> enrolledCourses;
  final List<String> quizResults;
  final List<String> certificates;

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
