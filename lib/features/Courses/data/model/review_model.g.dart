// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: json['_id'] as String,
  userId: UserModel.fromJson(json['user_id']),
  courseId: json['course_id'] as String,
  rating: json['rating'] as int,
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'courseId': instance.courseId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
