import 'package:equatable/equatable.dart';
import 'package:llearning/features/Auth/data/model/UserModel.dart';
import 'package:llearning/features/home/data/models/CategoryEntityModel.dart';

import '../../data/model/UserEntityModelforCourse.dart';

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final UserModel createdBy; // ObjectId reference as a String
  final CategoryEntityModel? categoryId; // ObjectId reference as a String
  final double price;
  final String duration;
  final String level;
  final String thumbnail;
  final DateTime createdAt;
  final List<String> lessons; // List of ObjectId references
  final List<String> quizzes; // List of ObjectId references
  final List<String> reviews; // List of ObjectId references
  final List<String> certificates; // List of ObjectId references

  const CourseEntity({
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
