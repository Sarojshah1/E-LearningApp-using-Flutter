// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quiz_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserQuizResultModel _$UserQuizResultModelFromJson(Map<String, dynamic> json) => UserQuizResultModel(
  id: json['_id'] as String,
  userId: json['user_id'] as String,
  quizId: QuizModel.fromJson(json['quiz_id'] as Map<String, dynamic>),
  score: json['score'] as int,
  status: json['status'] as String,
  attemptedAt: DateTime.parse(json['attempted_at'] as String),
);

Map<String, dynamic> _$UserQuizResultModelToJson(UserQuizResultModel instance) => <String, dynamic>{
  '_id': instance.id,
  'user_id': instance.userId,
  'quiz_id': instance.quizId,
  'score': instance.score,
  'status': instance.status,
  'attempted_at': instance.attemptedAt.toIso8601String(),
};
