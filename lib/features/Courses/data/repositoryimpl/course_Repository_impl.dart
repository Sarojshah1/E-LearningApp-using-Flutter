import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/data/data_Source/courseremotedatasource.dart';
import 'package:llearning/features/Courses/domain/repository/course_Repository.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../model/course_model.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  if (connectivityStatus == ConnectivityStatus.isConnected) {
    final courseRemoteDataSource = ref.read(courseRemoteDataSourceProvider);
    return CourseRepositoryImpl(remoteDataSource: courseRemoteDataSource);
  } else {
    throw Exception('No internet connection');
  }
});
class CourseRepositoryImpl extends CourseRepository{
  final CourseRemoteDataSource remoteDataSource;
  CourseRepositoryImpl({
    required this.remoteDataSource
});
  @override
  Future<Either<Failure, List<CourseModel>>> getCourses({required int page, required int limit}) async{
    return await remoteDataSource.getCourses(page: page, limit: limit);
  }
  @override
  Future<Either<Failure, CourseModel>> getCoursesById(String courseId) async{
    return await remoteDataSource.getCoursesById(courseId);
  }
  @override
  Future<Either<Failure, bool>> createPayment({required String course_id, required int amount, required String payment_method, required String status}) async{
    return await remoteDataSource.createPayment(course_id: course_id, amount: amount, payment_method: payment_method, status: status);
  }

}