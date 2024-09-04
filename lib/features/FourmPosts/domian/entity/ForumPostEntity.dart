import 'package:equatable/equatable.dart';
import 'package:llearning/features/Courses/data/model/UserEntityModelforCourse.dart';

class CommentReply extends Equatable {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;

  const CommentReply({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, content, createdAt];
}

class Comment extends Equatable {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final List<CommentReply> replies;

  const Comment({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.replies,
  });

  @override
  List<Object?> get props => [id, userId, content, createdAt, replies];
}

class ForumPostEntity extends Equatable {
  final String id;
  final UserModel userId;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final List<String> likes;
  final List<Comment> comments;

  const ForumPostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.likes,
    required this.comments,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    content,
    createdAt,
    updatedAt,
    tags,
    likes,
    comments,
  ];
}
