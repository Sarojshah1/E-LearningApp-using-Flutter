import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/StudyGroups/data/repositoryImpl/group_chat_repositoryImpl.dart';
import 'package:llearning/features/StudyGroups/domain/repository/group_chat_repository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/group_study_model.dart';
final studyGroupUseCaseProvider =Provider.autoDispose<StudyGroupUseCase>((ref){
  return StudyGroupUseCase(repository: ref.read(groupChatRepositoryImplProvider));
});
class StudyGroupUseCase{
  final GroupChatRepository repository;
  StudyGroupUseCase({
    required this.repository
});
  Future<Either<Failure, bool>> createGroup(String group_name, String description) async{
    return await repository.createGroup(group_name, description);
  }
  Future<Either<Failure, List<GroupStudy>>> getGroups()async{
    return await repository.getGroups();

  }
  Future<Either<Failure,bool>> joinGroup(String groupId)async{
    return await repository.joinGroup(groupId);
  }
  Future<Either<Failure,List<GroupStudy>>> getGroupsByUsers()async{
    return await repository.getGroupsByUsers();
  }
  Future<Either<Failure,GroupStudy>> getGroupsById(String groupId)async{
    return await repository.getGroupsById(groupId);
  }
  Future<Either<Failure,GroupStudy>> sendMessageToGroups(String groupId,String message)async{
    return await repository.sendMessageToGroups(groupId, message);
  }
}