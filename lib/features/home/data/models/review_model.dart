import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/ReviewEntity.dart';


part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final String courseId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  ReviewEntity toEntity() => ReviewEntity(
    id: id,
    userId: userId,
    courseId: courseId,
    rating: rating,
    comment: comment,
    createdAt: createdAt,
  );

  static ReviewModel fromEntity(ReviewEntity entity) => ReviewModel(
    id: entity.id,
    userId: entity.userId,
    courseId: entity.courseId,
    rating: entity.rating,
    comment: entity.comment,
    createdAt: entity.createdAt,
  );

  @override
  List<Object?> get props => [id, userId, courseId, rating, comment, createdAt];
}
