import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/LessonEntity.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel extends Equatable {
  final String id; // Corresponds to `_id` in MongoDB
  final String courseId;
  final String title;
  final String content;
  final String? videoUrl;
  final int order;

  const LessonModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.content,
    this.videoUrl,
    this.order = 0,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      courseId: courseId,
      title: title,
      content: content,
      videoUrl: videoUrl,
      order: order,
    );
  }

  static LessonModel fromEntity(LessonEntity entity) {
    return LessonModel(
      id: entity.id,
      courseId: entity.courseId,
      title: entity.title,
      content: entity.content,
      videoUrl: entity.videoUrl,
      order: entity.order,
    );
  }

  @override
  List<Object?> get props => [
    id,
    courseId,
    title,
    content,
    videoUrl,
    order,
  ];
}
