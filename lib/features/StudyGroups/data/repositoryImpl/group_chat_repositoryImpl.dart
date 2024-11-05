import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/StudyGroups/data/data_source/group_chat_data_source.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../../domain/repository/group_chat_repository.dart';
import '../model/group_study_model.dart';
final groupChatRepositoryImplProvider=Provider<GroupChatRepository>(
        (ref){
      final connectivityStatus = ref.watch(connectivityStatusProvider);

      if (connectivityStatus == ConnectivityStatus.isConnected) {
        final groupChatRemoteDataSource = ref.read(studyGroupDataSourceProvider);
        return GroupChatRepositoryImpl(dataSource: groupChatRemoteDataSource);
      } else {
        throw Exception('No internet connection');
      }
    }
);
class  GroupChatRepositoryImpl extends  GroupChatRepository{
  final StudyGroupDataSource dataSource;
  GroupChatRepositoryImpl({
    required this.dataSource
});
  @override
  Future<Either<Failure, bool>> createGroup(String group_name, String description) async{
    return await dataSource.createGroup(group_name, description);
  }
  @override
  Future<Either<Failure, List<GroupStudy>>> getGroups() async{
    return await dataSource.getGroups();
  }
  @override
  Future<Either<Failure, bool>> joinGroup(String groupId) async{
    return await dataSource.joinGroup(groupId);
  }
  @override
  Future<Either<Failure, List<GroupStudy>>> getGroupsByUsers() async{
    return await dataSource.getGroupsByUsers();
  }
  @override
  Future<Either<Failure, GroupStudy>> getGroupsById(String groupId) async{
    return await dataSource.getGroupsById(groupId);
  }
  @override
  Future<Either<Failure, GroupStudy>> sendMessageToGroups(String groupId, String message) async{
    return await dataSource.sendMessageToGroups(groupId, message);
  }


}