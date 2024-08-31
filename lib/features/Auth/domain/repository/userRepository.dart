import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../data/model/UserModel.dart';
import '../../domain/Entity/UserEntity.dart';
import '../../../../cores/failure/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> createUser(UserEntity user, File? profilePicture);
  Future<Either<Failure, UserEntityModel>> getUsers();
  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword);
  Future<Either<Failure, bool>> updateUserDetails(UserEntity user);
  Future<Either<Failure, bool>> updateProfilePicture(File? profilePicture);

}
