// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ForumPostModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentReplyModel _$CommentReplyModelFromJson(Map<String, dynamic> json) =>
    CommentReplyModel(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentReplyModelToJson(CommentReplyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['_id'] as String,
  userId: json['user_id'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  replies: (json['replies'] as List<dynamic>)
      .map((e) => CommentReplyModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'replies': instance.replies.map((e) => e.toJson()).toList(),
    };

ForumPostModel _$ForumPostModelFromJson(Map<String, dynamic> json) =>
    ForumPostModel(
      id: json['_id'] as String,
      userId: UserModel.fromJson(json['user_id'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForumPostModelToJson(ForumPostModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId.toJson(),
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'tags': instance.tags,
      'likes': instance.likes,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
