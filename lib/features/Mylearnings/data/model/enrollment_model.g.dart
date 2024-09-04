// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mylearningModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentModel _$EnrollmentModelFromJson(Map<String, dynamic> json) {
  return EnrollmentModel(
    id: json['_id'] as String,
    userId: json['user_id'] as String,
    courseId: CourseModel.fromJson(json['course_id']),
    enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
    status: json['status'] as String? ?? 'in-progress',
    progress: json['progress'] as int? ?? 0,
    completedAt: json['completed_at'] == null
        ? null
        : DateTime.parse(json['completed_at'] as String),
  );
}

Map<String, dynamic> _$EnrollmentModelToJson(EnrollmentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'course_id': instance.courseId,
      'enrollment_date': instance.enrollmentDate.toIso8601String(),
      'status': instance.status,
      'progress': instance.progress,
      'completed_at': instance.completedAt?.toIso8601String(),
    };
