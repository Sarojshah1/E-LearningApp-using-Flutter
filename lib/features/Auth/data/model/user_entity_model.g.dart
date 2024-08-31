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
  profilePicture: json['profilePicture'] as String,
  bio: json['bio'] as String? ?? '',
  enrolledCourses: (json['enrolledCourses'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  payments: (json['payments'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  blogPosts: (json['blogPosts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  quizResults: (json['quizResults'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  reviews: (json['reviews'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  certificates: (json['certificates'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
);

Map<String, dynamic> _$UserEntityModelToJson(UserEntityModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'role': instance.role,
  'profilePicture': instance.profilePicture,
  'bio': instance.bio,
  'enrolledCourses': instance.enrolledCourses,
  'payments': instance.payments,
  'blogPosts': instance.blogPosts,
  'quizResults': instance.quizResults,
  'reviews': instance.reviews,
  'certificates': instance.certificates,
};