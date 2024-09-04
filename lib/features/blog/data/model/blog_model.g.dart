// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return BlogModel(
    id: json['_id'] as String,
    userId: UserModel.fromJson(json['user_id']),
    content: json['content'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
    tags: (json['tags']as List<dynamic>).map((e) => e as String).toList(),
    title: json['title'] as String
  );
}

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id':instance.userId,
      'content':instance.content,
      'created_at':instance.createdAt,
      'title':instance.title,
      'tags':instance.tags
    };
