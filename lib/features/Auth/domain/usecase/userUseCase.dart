import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/cores/failure/failure.dart';
import 'package:llearning/features/Auth/data/repositoryImpl/UserRepositoryImpl.dart';
import 'package:llearning/features/Auth/domain/repository/userRepository.dart';

import '../../data/model/UserModel.dart';
import '../Entity/UserEntity.dart';

final userUsecaseProvider =Provider((ref){
  return userUsecase(ref.read(userRepositoryProvider));
});
class userUsecase{
  final UserRepository userRepository;
  userUsecase( this.userRepository);
  Future<Either<Failure, bool>> createUser(UserEntity user, File? profilePicture)async{
    return await userRepository.createUser(user, profilePicture);
  }
  Future<Either<Failure, UserEntityModel>> getUsers()async{
    return await userRepository.getUsers();
  }
  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword)async{
    return await userRepository.changePassword(oldPassword, newPassword);
  }
  Future<Either<Failure, bool>> updateUserDetails(UserEntity user)async{
    return await userRepository.updateUserDetails(user);
  }

  Future<Either<Failure, bool>> updateProfilePicture(File? profilePicture)async{
    return await userRepository.updateProfilePicture(profilePicture);
  }

  Future<Either<Failure,bool>> userLogin(  String email,  String password) async{
    return await userRepository.userLogin(email, password);

  }
  Future<Either<Failure,String>> sendOtp(String email)async{
    return await userRepository.sendOtp(email);
  }
  Future<Either<Failure,String>> verifyOtp(String otp,String email)async{
    return await userRepository.verifyOtp(otp, email);
  }
  Future<Either<Failure,String>> ForgetPassword(String password,String email)async{
    return await userRepository.ForgetPassword(password, email);
  }
}