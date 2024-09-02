import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final String courseId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  ReviewEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, courseId, rating, comment, createdAt];
}
