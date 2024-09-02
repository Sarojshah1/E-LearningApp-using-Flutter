import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String quizId;
  final String questionText;
  final String questionType;
  final List<String> options; // Only for multiple_choice questions
  final String correctAnswer;

  QuestionEntity({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.correctAnswer,
  });

  @override
  List<Object?> get props => [id, quizId, questionText, questionType, options, correctAnswer];
}
