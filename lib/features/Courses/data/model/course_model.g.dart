// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  id: json['_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  createdBy: UserModel.fromJson(json['created_by']) ,
  categoryId: CategoryEntityModel.fromJson(json['category_id'] as Map<String, dynamic>),
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  duration: json['duration'] as String,
  level: json['level'] as String? ?? 'beginner',
  thumbnail: json['thumbnail'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  lessons: (json['lessons'] as List<dynamic>)
      .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  quizzes: (json['quizzes'] as List<dynamic>).map((e) => QuizModel.fromJson(e as Map<String, dynamic>)).toList(),
  reviews: (json['reviews'] as List<dynamic>).map((e) => e as String).toList(),
  certificates: (json['certificates'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'created_by': instance.createdBy,
  'category_id': instance.categoryId,
  'price': instance.price,
  'duration': instance.duration,
  'level': instance.level,
  'thumbnail': instance.thumbnail,
  'created_at': instance.createdAt.toIso8601String(),
  'lessons': instance.lessons,
  'quizzes': instance.quizzes,
  'reviews': instance.reviews,
  'certificates': instance.certificates,
};
