import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/Courses/data/model/course_model.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';

final courseRemoteDataSourceProvider = Provider<CourseRemoteDataSource>(
      (ref) => CourseRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    // courseModel: ref.watch(Cour),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);
class CourseRemoteDataSource {
  final Dio dio;
  // final CourseModel courseModel;
  final UserSharedPrefs userSharedPrefs;

  CourseRemoteDataSource({
    required this.dio,
    // required this.courseModel,
    required this.userSharedPrefs
  });
 Future<Either<Failure, List<CourseModel>>> getCourses({required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      // Use the token in the request header if needed
      Response response = await dio.get(
        ApiEndpoints.getCourses,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> courseJsonList = response.data as List<dynamic>;
        final List<CourseModel> courses = courseJsonList
            .map((json) => CourseModel.fromJson(json))
            .toList();

        return right(courses);
      } else {
        return left(Failure(error: "Failed to load courses"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.message.toString()));
    }
  }
  Future<Either<Failure, bool>> createPayment({required String course_id, required int amount,required String payment_method,required String status}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      // Use the token in the request header if needed
      Response response = await dio.post(
        ApiEndpoints.payment,
        data: {
          'course_id': course_id,
          'amount': amount,
          'payment_method': payment_method,
          'status': status,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {

        return right(true);
      } else {
        return left(Failure(error: "Failed to load courses"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.message.toString()));
    }
  }
  Future<Either<Failure, CourseModel>> getCoursesById(String courseId) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      // Use the token in the request header if needed
      Response response = await dio.get(
        ApiEndpoints.getCourseUrl(courseId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final CourseJson = response.data;
        final CourseModel courses =CourseModel.fromJson(CourseJson);

        return right(courses);
      } else {
        return left(Failure(error: "Failed to load courses"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.message.toString()));
    }
  }
}