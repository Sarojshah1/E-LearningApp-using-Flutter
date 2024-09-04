import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/blog/data/model/blog_model.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';

final blogRemoteDataSourceProvider=Provider<BlogRemoteDataSource>(
    (ref)=>BlogRemoteDataSource(dio: ref.watch(httpServiceProvider), userSharedPrefs: ref.watch(userSharedPrefsProvider))
);
class BlogRemoteDataSource{
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  BlogRemoteDataSource({
   required this.dio,
    required this.userSharedPrefs
});
  Future<Either<Failure,List<BlogModel>>> getBlogs()async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authtoken=token.fold((l) => throw Failure(error: l.error), (r) => r);
      Response response =await dio.get(ApiEndpoints.getBlogs);
      if(response.statusCode==200){
        final List<dynamic> responsedata=response.data;
        final List<BlogModel> blogs=responsedata.map((json)=>BlogModel.fromJson(json)).toList();
        return right(blogs);
      }else {
        return left(Failure(error: "Failed to load reviews"));
      }

    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }
  }
}