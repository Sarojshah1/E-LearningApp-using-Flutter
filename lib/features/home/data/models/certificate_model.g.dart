// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateModel _$CertificateModelFromJson(Map<String, dynamic> json) => CertificateModel(
  id: json['_id'] as String,
  userId: json['user_id'] as String,
  courseId: CourseModel.fromJson(json['course_id'] as Map<String, dynamic>),
  issuedAt: DateTime.parse(json['issued_at'] as String),
  certificate: json['certificate'] as String,
);

Map<String, dynamic> _$CertificateModelToJson(CertificateModel instance) => <String, dynamic>{
  '_id': instance.id,
  'user_id': instance.userId,
  'course_id': instance.courseId,
  'issued_at': instance.issuedAt.toIso8601String(),
  'certificate': instance.certificate,
};
