// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) => QuestionModel(
  id: json['_id'] as String,
  quizId: json['quiz_id'] as String,
  questionText: json['question_text'] as String,
  questionType: json['question_type'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctAnswer: json['correct_answer'] as String,
);

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) => <String, dynamic>{
  '_id': instance.id,
  'quiz_id': instance.quizId,
  'question_text': instance.questionText,
  'question_type': instance.questionType,
  'options': instance.options,
  'correct_answer': instance.correctAnswer,
};
