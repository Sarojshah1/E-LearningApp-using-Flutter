// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: json['_id'] as String,
  courseId: json['courseId'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  videoUrl: json['videoUrl'] as String?,
  order: json['order'] as int? ?? 0,
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'courseId': instance.courseId,
      'title': instance.title,
      'content': instance.content,
      'videoUrl': instance.videoUrl,
      'order': instance.order,
    };
