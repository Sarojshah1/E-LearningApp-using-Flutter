import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llearning/features/home/data/models/QuizModel.dart';import '../../domain/entity/UserQuizResultEntity.dart';


part 'user_quiz_result_model.g.dart';

@JsonSerializable()
class UserQuizResultModel extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final QuizModel quizId;
  final int score;
  final String status;
  final DateTime attemptedAt;

  UserQuizResultModel({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.status,
    required this.attemptedAt,
  });

  factory UserQuizResultModel.fromJson(Map<String, dynamic> json) => _$UserQuizResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserQuizResultModelToJson(this);

  UserQuizResultEntity toEntity() => UserQuizResultEntity(
    id: id,
    userId: userId,
    quizId: quizId,
    score: score,
    status: status,
    attemptedAt: attemptedAt,
  );

  static UserQuizResultModel fromEntity(UserQuizResultEntity entity) => UserQuizResultModel(
    id: entity.id,
    userId: entity.userId,
    quizId: entity.quizId,
    score: entity.score,
    status: entity.status,
    attemptedAt: entity.attemptedAt,
  );

  @override
  List<Object?> get props => [id, userId, quizId, score, status, attemptedAt];
}
