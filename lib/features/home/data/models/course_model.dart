import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/course_entity.dart';

part 'course_model.g.dart'; // This file will be generated

@JsonSerializable()
class CourseModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'created_by')
  final String createdBy;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  final double price;
  final String duration;
  final String level;
  final String thumbnail;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'lessons')
  final List<String> lessons;
  @JsonKey(name: 'quizzes')
  final List<String> quizzes;
  @JsonKey(name: 'reviews')
  final List<String> reviews;
  @JsonKey(name: 'certificates')
  final List<String> certificates;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    this.categoryId,
    this.price = 0.0,
    required this.duration,
    this.level = 'beginner',
    required this.thumbnail,
    required this.createdAt,
    required this.lessons,
    required this.quizzes,
    required this.reviews,
    required this.certificates,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      title: title,
      description: description,
      createdBy: createdBy,
      categoryId: categoryId, // Convert nested CategoryEntityModel to CourseEntity
      price: price,
      duration: duration,
      level: level,
      thumbnail: thumbnail,
      createdAt: createdAt,
      lessons: lessons, // Convert nested LessonModel to Entity
      quizzes: quizzes,
      reviews: reviews,
      certificates: certificates,
    );
  }

  static CourseModel fromEntity(CourseEntity entity) {
    return CourseModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdBy: entity.createdBy,
      categoryId: entity.categoryId ,
      price: entity.price,
      duration: entity.duration,
      level: entity.level,
      thumbnail: entity.thumbnail,
      createdAt: entity.createdAt,
      lessons: entity.lessons.map((lesson) => lesson).toList(),
      quizzes: entity.quizzes.toList(),
      reviews: entity.reviews.toList(),
      certificates: entity.certificates.toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    createdBy,
    categoryId,
    price,
    duration,
    level,
    thumbnail,
    createdAt,
    lessons,
    quizzes,
    reviews,
    certificates,
  ];
}
