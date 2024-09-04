import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/models/course_model.dart';
import '../../domain/entity/mylearnings_entity.dart';

part 'enrollment_model.g.dart'; // This file will be generated

@JsonSerializable()
class EnrollmentModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'course_id')
  final CourseModel courseId;
  @JsonKey(name: 'enrollment_date')
  final DateTime enrollmentDate;
  final String status;
  final int progress;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  const EnrollmentModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.enrollmentDate,
    this.status = 'in-progress',
    this.progress = 0,
    this.completedAt,
  });

  // JSON serialization
  factory EnrollmentModel.fromJson(Map<String, dynamic> json) => _$EnrollmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentModelToJson(this);

  // Convert model to entity
  EnrollmentEntity toEntity() {
    return EnrollmentEntity(
      id: id,
      userId: userId,  // Assuming minimal UserEntity here
      courseId: courseId,  // Assuming minimal CourseEntity here
      enrollmentDate: enrollmentDate,
      status: status,
      progress: progress,
      completedAt: completedAt,
    );
  }

  // Convert entity to model
  static EnrollmentModel fromEntity(EnrollmentEntity entity) {
    return EnrollmentModel(
      id: entity.id,
      userId: entity.userId,
      courseId: entity.courseId,
      enrollmentDate: entity.enrollmentDate,
      status: entity.status,
      progress: entity.progress,
      completedAt: entity.completedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    courseId,
    enrollmentDate,
    status,
    progress,
    completedAt,
  ];
}
