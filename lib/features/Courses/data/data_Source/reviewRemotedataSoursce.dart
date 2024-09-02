import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/Courses/data/model/ReviewModel.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';

final reviewRemoteDataSourseProvider=Provider<ReviewRemoteDataSource>(
    (ref)=>ReviewRemoteDataSource(dio: ref.watch(httpServiceProvider), userSharedPrefs: ref.watch(userSharedPrefsProvider))
);
class ReviewRemoteDataSource{
  final Dio dio;
  // final ReviewModel reviewModel;
  final UserSharedPrefs userSharedPrefs;

  ReviewRemoteDataSource({
    required this.dio,
    // required this.reviewModel,
    required this.userSharedPrefs
});

  Future<Either<Failure,List<ReviewModel>>> getReviews(String courseId) async {
try{
  final token = await userSharedPrefs.getUserToken();
  final authToken = token.fold(
        (l) => throw Failure(error: l.error),
        (r) => r,
  );

   Response response =await dio.get(ApiEndpoints.getReviewUrl(courseId),options: Options(
     headers: {
       'Authorization': 'Bearer $authToken',
     },
   ),);
   print(response.data);
   if(response.statusCode==200){
    final List<dynamic> responsedata=response.data;
    final List<ReviewModel> reviews=responsedata.map((json)=>ReviewModel.fromJson(json)).toList();
    return right(reviews);
   }else {
     return left(Failure(error: "Failed to load reviews"));
   }
}on DioException catch(e){
  return left(Failure(error: e.message.toString()));
}
  }

  Future<Either<Failure,bool>> addreview(String courseId,String comment,int rating)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      
      Response response=await dio.post(ApiEndpoints.addReviews,data:{
        'course_id':courseId,
        'rating':rating,
        'comment':comment
      },options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ), );
      return right(true);
      
    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }

}