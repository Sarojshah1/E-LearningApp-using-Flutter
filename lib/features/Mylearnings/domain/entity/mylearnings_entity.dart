import 'package:equatable/equatable.dart';

import '../../../home/data/models/course_model.dart';

class EnrollmentEntity extends Equatable {
  final String id;
  final String userId;
  final CourseModel courseId;
  final DateTime enrollmentDate;
  final String status;
  final int progress;
  final DateTime? completedAt;

  const EnrollmentEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.enrollmentDate,
    this.status = 'in-progress',
    this.progress = 0,
    this.completedAt,
  });

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
