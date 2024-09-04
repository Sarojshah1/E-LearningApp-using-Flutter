import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
import '../model/ForumPostModel.dart';
final FormPostDataSourceProvider=Provider<FormPostDataSource>(
    (ref)=>FormPostDataSource(dio: ref.watch(httpServiceProvider), userSharedPrefs: ref.watch(userSharedPrefsProvider))
);
class FormPostDataSource{
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FormPostDataSource({
    required this.dio,
    required this.userSharedPrefs
});

  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.post(ApiEndpoints.createPost,
        data: {
        "title":title,
          "content":content,
          "tags":tags
        },
        options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==201){
        return right(true);
      }else{
        return left(Failure(error: "faild to create post"));
      }

    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }

  Future<Either<Failure,List<ForumPostModel>>> getPost()async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.get(ApiEndpoints.getPost,
          options: Options(
            headers: {
              'Authorization': 'Bearer $authToken',
            },
          ));
      if(response.statusCode==200){
        final List<dynamic> postJson=response.data;
        final List<ForumPostModel> posts=postJson.map((json) => ForumPostModel.fromJson(json))
            .toList();
        return right(posts);
      }else{
        return left(Failure(error: "Failed to load posts"));
      }

    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }
}