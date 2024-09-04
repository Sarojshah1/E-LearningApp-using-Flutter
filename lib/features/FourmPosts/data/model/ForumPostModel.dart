import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../Courses/data/model/UserEntityModelforCourse.dart';
import '../../domian/entity/ForumPostEntity.dart';


part 'forum_post_model.g.dart'; // This file will be generated

@JsonSerializable()
class CommentReplyModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const CommentReplyModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory CommentReplyModel.fromJson(Map<String, dynamic> json) => _$CommentReplyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentReplyModelToJson(this);

  CommentReply toEntity() {
    return CommentReply(
      id: id,
      userId: userId,
      content: content,
      createdAt: createdAt,
    );
  }

  static CommentReplyModel fromEntity(CommentReply entity) {
    return CommentReplyModel(
      id: entity.id,
      userId: entity.userId,
      content: entity.content,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, content, createdAt];
}

@JsonSerializable()
class CommentModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<CommentReplyModel> replies;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  Comment toEntity() {
    return Comment(
      id: id,
      userId: userId,
      content: content,
      createdAt: createdAt,
      replies: replies.map((reply) => reply.toEntity()).toList(),
    );
  }

  static CommentModel fromEntity(Comment entity) {
    return CommentModel(
      id: entity.id,
      userId: entity.userId,
      content: entity.content,
      createdAt: entity.createdAt,
      replies: entity.replies.map((reply) => CommentReplyModel.fromEntity(reply)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, userId, content, createdAt, replies];
}

@JsonSerializable()
class ForumPostModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final UserModel userId;
  final String title;
  final String content;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final List<String> tags;
  final List<String> likes;
  final List<CommentModel> comments;

  const ForumPostModel({
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

  factory ForumPostModel.fromJson(Map<String, dynamic> json) => _$ForumPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForumPostModelToJson(this);

  ForumPostEntity toEntity() {
    return ForumPostEntity(
      id: id,
      userId: userId,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tags: tags,
      likes: likes,
      comments: comments.map((comment) => comment.toEntity()).toList(),
    );
  }

  static ForumPostModel fromEntity(ForumPostEntity entity) {
    return ForumPostModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      tags: entity.tags.toList(),
      likes: entity.likes.toList(),
      comments: entity.comments.map((comment) => CommentModel.fromEntity(comment)).toList(),
    );
  }

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
