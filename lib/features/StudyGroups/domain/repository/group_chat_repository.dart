import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/group_study_model.dart';

abstract class GroupChatRepository{
  Future<Either<Failure,bool>> createGroup(String group_name,String description);
  Future<Either<Failure,List<GroupStudy>>> getGroups();
  Future<Either<Failure,bool>> joinGroup(String groupId);
  Future<Either<Failure,List<GroupStudy>>> getGroupsByUsers();
  Future<Either<Failure,GroupStudy>> getGroupsById(String groupId);
  Future<Either<Failure,GroupStudy>> sendMessageToGroups(String groupId,String message);
}