import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:llearning/features/Auth/data/model/UserModel.dart';
import 'package:llearning/features/home/data/models/course_model.dart';
import '../../domain/entity/certificate_entity.dart';


part 'certificate_model.g.dart';

@JsonSerializable()
class CertificateModel extends Equatable {
  final String id; // Represents the ObjectId from MongoDB
  final String userId;
  final CourseModel courseId;
  final DateTime issuedAt;
  final String certificate;

  CertificateModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.issuedAt,
    required this.certificate,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) => _$CertificateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateModelToJson(this);

  CertificateEntity toEntity() => CertificateEntity(
    id: id,
    userId: userId,
    courseId: courseId,
    issuedAt: issuedAt,
    certificate: certificate,
  );

  static CertificateModel fromEntity(CertificateEntity entity) => CertificateModel(
    id: entity.id,
    userId: entity.userId,
    courseId: entity.courseId,
    issuedAt: entity.issuedAt,
    certificate: entity.certificate,
  );

  @override
  List<Object?> get props => [id, userId, courseId, issuedAt, certificate];
}
