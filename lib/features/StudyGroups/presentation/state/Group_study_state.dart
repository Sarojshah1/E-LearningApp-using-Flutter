import 'package:flutter/foundation.dart';

import '../../data/model/group_study_model.dart';

class GroupStudyState {
  final bool isLoading;
  final String? error;
  final List<GroupStudy> studyGroups;
  final GroupStudy? group;
  final bool hasReachedMax;
  final int page;


  GroupStudyState({
    required this.isLoading,
    this.error,
    required this.studyGroups,
    this.group,
    required this.hasReachedMax,
    required this.page,

  });

  factory GroupStudyState.initial() {
    return GroupStudyState(
        isLoading: false,
        error: null,
        studyGroups: [],
        group: null,
        hasReachedMax: false,page: 0
    );
  }

  GroupStudyState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? page,
    List<GroupStudy>? studyGroups,
    GroupStudy? group,

  }) {
    return GroupStudyState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      studyGroups: studyGroups ?? this.studyGroups,
     group: group?? this.group,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'ForumPostState(isLoading: $isLoading, error: $error, Groups: $studyGroups, group: $group)';
  }
}
