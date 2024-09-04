import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../Courses/data/model/UserEntityModelforCourse.dart';
import '../../domain/entity/blog_entity.dart';


part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel extends Equatable {
  final String id;
  final UserModel userId;
  final String title;
  final String content;
  final List<String> tags;
  final DateTime createdAt;

  const BlogModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.tags,
    required this.createdAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  BlogEntity toEntity() {
    return BlogEntity(
      id: id,
     userId: userId,
      title: title,
      tags: tags,
      content: content,
      createdAt: createdAt
    );
  }

  static BlogModel fromEntity(BlogEntity entity) {
    return BlogModel(
      id: entity.id,
      title: entity.title,
      userId: entity.userId,
      content: entity.content,
      tags: entity.tags,
      createdAt: entity.createdAt
    );
  }

  @override
  List<Object?> get props => [id, userId,title,tags,createdAt,content];
}
