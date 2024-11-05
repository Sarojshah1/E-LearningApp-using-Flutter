import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/StudyGroups/data/model/group_study_model.dart';
import 'package:llearning/features/StudyGroups/domain/usecases/study_group_usecase.dart';
import 'package:llearning/features/StudyGroups/presentation/state/Group_study_state.dart';
final studyGroupViewModelProvider = StateNotifierProvider<StudyGroupViewModel, GroupStudyState>(
        (ref) => StudyGroupViewModel(useCase: ref.read(studyGroupUseCaseProvider))
);
class StudyGroupViewModel extends StateNotifier<GroupStudyState>{
  final StudyGroupUseCase useCase;
  StudyGroupViewModel({
    required this.useCase
}):super(GroupStudyState.initial());
  Future<void> createGroups(String group_name, String description)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.createGroup(group_name, description);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (success)=>state=state.copyWith(isLoading: false));
  }
  Future<void> getGroups()async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.getGroups();
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (groups)=>state=state.copyWith(isLoading: false,studyGroups: groups));

  }
  Future<void> joinGroup(String groupId)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.joinGroup(groupId);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (success)=>state=state.copyWith(isLoading: false,error: null));

  }
  Future<void> getGroupsByUsers()async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.getGroupsByUsers();
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (groups)=>state=state.copyWith(isLoading: false,studyGroups: groups));

  }
  Future<void> getGroupsById(String groupId)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.getGroupsById(groupId);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (group)=>state=state.copyWith(isLoading: false,group: group));

  }
  Future<void> sendMessage(String groupId, String message) async {
    // Set loading state to true
    state = state.copyWith(isLoading: true);

    // Attempt to send the message
    final result = await useCase.sendMessageToGroups(groupId, message);

    result.fold(
          (failure) {
        // On failure, update state with error and set loading to false
        state = state.copyWith(isLoading: false, error: failure.error);
      },
          (success) {
        // On success, update state with new message
        final newMessage = success;

        // Append new message to the existing list
        final updatedChats = List<Chat>.from(state.group!.chats)..add(newMessage as Chat);

        // Update state with the new list and set loading to false
        state = state.copyWith(
          isLoading: false,
          group: state.group!.copyWith(chats: updatedChats),
        );
      },
    );
  }




}