import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llearning/features/home/data/models/question_model.dart';

import '../../domain/entity/QuizEntity.dart';


part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String courseId;
  final String title;
  final String description;
  final int totalMarks;
  final int passingMarks;
  final DateTime createdAt;
  final List<String> questions;

  const QuizModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.totalMarks,
    required this.passingMarks,
    required this.createdAt,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  QuizEntity toEntity() => QuizEntity(
    id: id,
    courseId: courseId,
    title: title,
    description: description,
    totalMarks: totalMarks,
    passingMarks: passingMarks,
    createdAt: createdAt,
    questions: questions,
  );

  static QuizModel fromEntity(QuizEntity entity) => QuizModel(
    id: entity.id,
    courseId: entity.courseId,
    title: entity.title,
    description: entity.description,
    totalMarks: entity.totalMarks,
    passingMarks: entity.passingMarks,
    createdAt: entity.createdAt,
    questions: entity.questions.toList(),
  );

  @override
  List<Object?> get props => [id, courseId, title, description, totalMarks, passingMarks, createdAt, questions];
}
