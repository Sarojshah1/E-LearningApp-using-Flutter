import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/data/repositoryimpl/course_Repository_impl.dart';
import 'package:llearning/features/Courses/domain/repository/course_Repository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/course_model.dart';
final courseUsecaseProvider =Provider.autoDispose<CourseUseCase>((ref){
  return CourseUseCase(ref.read(courseRepositoryProvider));
});
class CourseUseCase{
  final CourseRepository courseRepository;
  CourseUseCase(
  this.courseRepository
);
  Future<Either<Failure, List<CourseModel>>> getCourses({required int page, required int limit}) async{
    return courseRepository.getCourses(page: page, limit: limit);
  }

}