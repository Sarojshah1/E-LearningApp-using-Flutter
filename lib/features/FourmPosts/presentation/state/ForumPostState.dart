import 'package:flutter/foundation.dart';

import '../../data/model/ForumPostModel.dart';

class ForumPostState {
  final bool isLoading;
  final String? error;
  final List<ForumPostModel> forumPosts;
  final ForumPostModel? forumPost;
  final bool hasReachedMax;
  final int page;


  ForumPostState({
    required this.isLoading,
    this.error,
    required this.forumPosts,
    this.forumPost,
    required this.hasReachedMax,
    required this.page,

  });

  factory ForumPostState.initial() {
    return ForumPostState(
      isLoading: false,
      error: null,
      forumPosts: [],
      forumPost: null,
        hasReachedMax: false,page: 0
    );
  }

  ForumPostState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? page,
    List<ForumPostModel>? forumPosts,
    ForumPostModel? forumPost,

  }) {
    return ForumPostState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      forumPosts: forumPosts ?? this.forumPosts,
      forumPost: forumPost ?? this.forumPost,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return 'ForumPostState(isLoading: $isLoading, error: $error, forumPosts: $forumPosts, forumPost: $forumPost)';
  }
}
