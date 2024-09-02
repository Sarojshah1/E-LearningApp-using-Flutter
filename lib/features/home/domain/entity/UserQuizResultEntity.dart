import 'package:equatable/equatable.dart';
import 'package:llearning/features/home/data/models/QuizModel.dart';

class UserQuizResultEntity extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final QuizModel quizId;
  final int score;
  final String status;
  final DateTime attemptedAt;

  UserQuizResultEntity({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.status,
    required this.attemptedAt,
  });

  @override
  List<Object?> get props => [id, userId, quizId, score, status, attemptedAt];
}
