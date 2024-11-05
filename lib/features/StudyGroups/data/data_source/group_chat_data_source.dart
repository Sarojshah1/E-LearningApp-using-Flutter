import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/StudyGroups/data/model/group_study_model.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
final studyGroupDataSourceProvider=Provider<StudyGroupDataSource>(
    (ref)=>StudyGroupDataSource(dio: ref.watch(httpServiceProvider), userSharedPrefs: ref.watch(userSharedPrefsProvider))
);
class StudyGroupDataSource{
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  StudyGroupDataSource({
    required this.dio,
    required this.userSharedPrefs
});
  Future<Either<Failure,bool>> createGroup(String group_name,String description)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response =await dio.post(ApiEndpoints.createGroup,
      data: {
        'group_name':group_name,
        'description':description
      },options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),);
      if(response.statusCode==201){
        return right(true);
      }else{
        return left(Failure(error: "fail to create group"));
      }
    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }
  Future<Either<Failure,List<GroupStudy>>> getGroups()async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.get(ApiEndpoints.getAllGroups,options: Options(
      headers: {
      'Authorization': 'Bearer $authToken',
      },
      ),);
      if(response.statusCode==200){
        final List<dynamic> groupJsonList = response.data as List<dynamic>;
        final List<GroupStudy> groups = groupJsonList
            .map((json) => GroupStudy.fromJson(json))
            .toList();
        return right(groups);

      }else{
        return left(Failure(error: "fail to load Groups"));
      }


    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }
  }
  Future<Either<Failure,bool>> joinGroup(String groupId)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.post(ApiEndpoints.getGroupMemberUrl(groupId),options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==201){
        return right(true);

      }else{
        return left(Failure(error: "fail to add member"));
      }


    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }
  Future<Either<Failure,List<GroupStudy>>> getGroupsByUsers()async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final userIdr=await userSharedPrefs.getUserId();
      final userId=userIdr.fold((l) => throw Failure(error: l.error),
            (r) => r,);

      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.get(ApiEndpoints.getUserGroupsUrl(userId!),options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==200){
        final List<dynamic> groupJsonList = response.data as List<dynamic>;
        final List<GroupStudy> groups = groupJsonList
            .map((json) => GroupStudy.fromJson(json))
            .toList();
        return right(groups);

      }else{
        return left(Failure(error: "fail to load Groups"));
      }


    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }
  }
  Future<Either<Failure,GroupStudy>> getGroupsById(String groupId)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.get(ApiEndpoints.getGroupsUrl(groupId),options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==200){
        final groupStudy = GroupStudy.fromJson(response.data);
        return right(groupStudy);

      }else{
        return left(Failure(error: "fail to load Groups"));
      }


    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }
  }
  Future<Either<Failure,GroupStudy>> sendMessageToGroups(String groupId,String message)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.post(ApiEndpoints.getGroupChatUrl(groupId),data: {
        'message':message
      },options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==200){
        final groupStudy = GroupStudy.fromJson(response.data);
        return right(groupStudy);

      }else{
        return left(Failure(error: "fail to load Groups"));
      }


    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }
  }


}