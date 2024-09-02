import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/question_entity.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String quizId;
  final String questionText;
  final String questionType;
  final List<String> options; // Only for multiple_choice questions
  final String correctAnswer;

  QuestionModel({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  QuestionEntity toEntity() => QuestionEntity(
    id: id,
    quizId: quizId,
    questionText: questionText,
    questionType: questionType,
    options: options,
    correctAnswer: correctAnswer,
  );

  static QuestionModel fromEntity(QuestionEntity entity) => QuestionModel(
    id: entity.id,
    quizId: entity.quizId,
    questionText: entity.questionText,
    questionType: entity.questionType,
    options: entity.options,
    correctAnswer: entity.correctAnswer,
  );

  @override
  List<Object?> get props => [id, quizId, questionText, questionType, options, correctAnswer];
}
