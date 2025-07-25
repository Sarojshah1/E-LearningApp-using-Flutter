import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../../domain/Entity/UserEntity.dart';

import '../../domain/repository/userRepository.dart';
import '../data_sources/UserRemoteDataSource.dart';
import '../model/UserModel.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  if (connectivityStatus == ConnectivityStatus.isConnected) {
    final userRemoteDataSource = ref.read(userRemoteDataSourceProvider);
    return UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
  } else {
    throw Exception('No internet connection');
  }
});
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createUser(UserEntity user, File? profilePicture) async {
    return await remoteDataSource.createUser(user, profilePicture);
  }

  @override
  Future<Either<Failure, UserEntityModel>> getUsers() async {
    return await remoteDataSource.getUsers();
  }
  @override
  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword) async{
    return await remoteDataSource.changePassword(oldPassword, newPassword);
  }
  @override
  Future<Either<Failure, bool>> updateUserDetails(UserEntity user) async{
   return await remoteDataSource.updateUserDetails(user);
  }
  @override
  Future<Either<Failure, bool>> updateProfilePicture(File? profilePicture) async{
   return await remoteDataSource.updateProfilePicture(profilePicture);
  }
  @override
  Future<Either<Failure, bool>> userLogin(String email, String password) async{
    return await remoteDataSource.userLogin(email: email, password: password);


  }
  @override
  Future<Either<Failure, String>> sendOtp(String email) async{
    return await remoteDataSource.sendOtp(email);
  }
  @override
  Future<Either<Failure, String>> verifyOtp(String otp, String email) async{
    return await remoteDataSource.verifyOtp(otp, email);
  }
  @override
  Future<Either<Failure, String>> ForgetPassword(String password, String email) async{
    return await remoteDataSource.ForgetPassword(password, email);
  }
}
