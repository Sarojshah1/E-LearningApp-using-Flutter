import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/Mylearnings/data/model/mylearningModel.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
final myLearningRemoteDataSourceProvider=Provider<MyLearningRemoteDataSource>(
    (ref)=>MyLearningRemoteDataSource(dio: ref.watch(httpServiceProvider),
      // courseModel: ref.watch(Cour),
      userSharedPrefs: ref.watch(userSharedPrefsProvider),)

);
class MyLearningRemoteDataSource {
  final Dio dio;

  final UserSharedPrefs userSharedPrefs;

  MyLearningRemoteDataSource(
      {required this.dio, required this.userSharedPrefs});
  Future<Either<Failure, List<EnrollmentModel>>> getLearnings() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
        (l) => throw Failure(error: l.error),
        (r) => r,
      );

      Response response=await dio.get(ApiEndpoints.getLearnings,options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==200){
    final List<dynamic> myLearningJson=response.data;
    final List<EnrollmentModel> enrolledcourses= myLearningJson.map((json) => EnrollmentModel.fromJson(json))
        .toList();
    return right(enrolledcourses);
      }else{
        return left(Failure(error: "Failed to load courses"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.error.toString()));
    }
  }
}
