import 'package:equatable/equatable.dart';
import 'package:llearning/features/home/data/models/course_model.dart';

class CertificateEntity extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final CourseModel courseId;
  final DateTime issuedAt;
  final String certificate;

  CertificateEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.issuedAt,
    required this.certificate,
  });

  @override
  List<Object?> get props => [id, userId, courseId, issuedAt, certificate];
}
