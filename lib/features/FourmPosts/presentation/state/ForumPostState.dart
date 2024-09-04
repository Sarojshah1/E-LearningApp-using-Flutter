import 'package:flutter/foundation.dart';

import '../../data/model/ForumPostModel.dart';

class ForumPostState {
  final bool isLoading;
  final String? error;
  final List<ForumPostModel> forumPosts;
  final ForumPostModel? forumPost;


  ForumPostState({
    required this.isLoading,
    this.error,
    required this.forumPosts,
    this.forumPost,

  });

  factory ForumPostState.initial() {
    return ForumPostState(
      isLoading: false,
      error: null,
      forumPosts: [],
      forumPost: null,
    );
  }

  ForumPostState copyWith({
    bool? isLoading,
    String? error,
    List<ForumPostModel>? forumPosts,
    ForumPostModel? forumPost,

  }) {
    return ForumPostState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      forumPosts: forumPosts ?? this.forumPosts,
      forumPost: forumPost ?? this.forumPost,
    );
  }

  @override
  String toString() {
    return 'ForumPostState(isLoading: $isLoading, error: $error, forumPosts: $forumPosts, forumPost: $forumPost)';
  }
}
