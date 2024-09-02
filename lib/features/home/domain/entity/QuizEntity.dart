import 'package:equatable/equatable.dart';
import 'package:llearning/features/home/data/models/question_model.dart';

class QuizEntity extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String courseId;
  final String title;
  final String description;
  final int totalMarks;
  final int passingMarks;
  final DateTime createdAt;
  final List<String> questions;

  const QuizEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.totalMarks,
    required this.passingMarks,
    required this.createdAt,
    required this.questions,
  });

  @override
  List<Object?> get props => [id, courseId, title, description, totalMarks, passingMarks, createdAt, questions];
}
