// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuizModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  id: json['_id'] as String,
  courseId: json['course_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  totalMarks: json['total_marks'] as int,
  passingMarks: json['passing_marks'] as int,
  createdAt: DateTime.parse(json['created_at'] as String),
  questions: (json['questions'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  '_id': instance.id,
  'course_id': instance.courseId,
  'title': instance.title,
  'description': instance.description,
  'total_marks': instance.totalMarks,
  'passing_marks': instance.passingMarks,
  'created_at': instance.createdAt.toIso8601String(),
  'questions': instance.questions,
};
