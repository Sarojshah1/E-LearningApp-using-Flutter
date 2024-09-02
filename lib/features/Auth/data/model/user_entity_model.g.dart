// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntityModel _$UserEntityModelFromJson(Map<String, dynamic> json) => UserEntityModel(
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  role: json['role'] as String,
  profilePicture: json['profile_picture'] as String?,
  bio: json['bio'] as String? ?? '',
  enrolledCourses: (json['enrolled_courses'] as List<dynamic>?)?.map((e) => e as CourseModel).toList() ?? [],
  quizResults: (json['quiz_results'] as List<dynamic>?)?.map((e) => e as UserQuizResultModel).toList() ?? [],
  certificates: (json['certificates'] as List<dynamic>?)?.map((e) => e as CertificateModel).toList() ?? [],
);

Map<String, dynamic> _$UserEntityModelToJson(UserEntityModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'role': instance.role,
  'profilePicture': instance.profilePicture,
  'bio': instance.bio,
  'enrolledCourses': instance.enrolledCourses,
  'quizResults': instance.quizResults,
  'certificates': instance.certificates,
};