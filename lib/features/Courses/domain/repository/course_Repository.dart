import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/course_model.dart';


abstract class CourseRepository{
  Future<Either<Failure, List<CourseModel>>> getCourses({required int page, required int limit});
  Future<Either<Failure, CourseModel>> getCoursesById(String courseId);
}