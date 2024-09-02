import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../App/constants/api_endpoints.dart';
import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/failure/failure.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
import '../../domain/Entity/UserEntity.dart';
import '../model/UserModel.dart';


final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>(
      (ref) => UserRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    userApiModel: ref.watch(userEntityModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class UserRemoteDataSource {
  final Dio dio;
  final UserEntityModel userApiModel;
  final UserSharedPrefs userSharedPrefs;

  UserRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.userApiModel,
  });

  Future<Either<Failure, bool>> createUser(UserEntity user,File? profilePicture) async {
    try {
      final formData = FormData.fromMap({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'role': user.role,
        'bio': user.bio ?? '',
        if (profilePicture != null)
          'profile_picture': await MultipartFile.fromFile(profilePicture.path, filename: profilePicture.uri.pathSegments.last),
      });
      final response = await dio.post(
        ApiEndpoints.register,
        data: formData,
      );
      if (response.statusCode == 201) {
        return Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'] ?? 'Failed to create user',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, UserEntityModel>> getUsers() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authtoken=token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(ApiEndpoints.profile,
          options: Options(
            headers: {
              'authorization': 'Bearer $authtoken',
            }));
      if (response.statusCode == 200) {
        final userJson = response.data;
        final UserEntityModel user = UserEntityModel.fromJson(userJson);
        return Right(user);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Failed to fetch users',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authtoken=token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.put(
        ApiEndpoints.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
          options: Options(
              headers: {
                'authorization': 'Bearer $authtoken',
              })
      );
      if (response.statusCode == 200) {
        return Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'] ?? 'Failed to change password',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
  Future<Either<Failure, bool>> updateUserDetails(UserEntity user) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authtoken=token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.put(
        ApiEndpoints.updateDetails,
        data: {
          'name': user.name,
          'email': user.email,
          'bio': user.bio ?? '',
        },
          options: Options(
              headers: {
                'authorization': 'Bearer $authtoken',
              })
      );
      if (response.statusCode == 200) {
        return Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'] ?? 'Failed to update user details',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
  Future<Either<Failure, bool>> updateProfilePicture(File? profilePicture) async {
    try {
      final token = await userSharedPrefs.getUserToken();
     final authtoken= token.fold((l) => throw Failure(error: l.error), (r) => r);
      final formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          profilePicture!.path,
          filename: profilePicture.uri.pathSegments.last,
        ),
      });

      final response = await dio.put(
        ApiEndpoints.updateProfilePicture,
        data: formData,
          options: Options(
              headers: {
                'authorization': 'Bearer $authtoken',
              })
      );

      if (response.statusCode == 200) {
        return Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'] ?? 'Failed to update profile picture',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure,bool>> userLogin( {required String email, required String password}) async{
    try{
      Response response =await dio.post(ApiEndpoints.login,
      data: {
        'email':email,
        'password':password
      }
      );
      if(response.statusCode==200){
        final token = response.data['token'];
        final role =response.data['role'];
        final id=response.data['id'];
        await userSharedPrefs.setUserToken(token);
        await userSharedPrefs.setUserRole(role);
        await userSharedPrefs.setUserId(id);

      }
      return const Right(true);
    }on DioException catch(e){
      return Left(Failure(error: e.error.toString()));
    }

  }

}
