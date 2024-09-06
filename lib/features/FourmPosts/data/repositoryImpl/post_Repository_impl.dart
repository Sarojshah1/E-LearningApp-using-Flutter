import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/data_souce/pose_data_source.dart';
import 'package:llearning/features/FourmPosts/domian/repository/postRepository.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../model/ForumPostModel.dart';

final postRepositoryImplProvider=Provider<PostRepository>(
    (ref){
      final connectivityStatus = ref.watch(connectivityStatusProvider);

      if (connectivityStatus == ConnectivityStatus.isConnected) {
        final postRemoteDataSource = ref.read(FormPostDataSourceProvider);
        return PostRepositoryImpl(dataSource: postRemoteDataSource);
      } else {
        throw Exception('No internet connection');
      }
    }
);
class PostRepositoryImpl extends PostRepository{
  final FormPostDataSource dataSource;
  PostRepositoryImpl({
    required this.dataSource
});
  @override
  Future<Either<Failure, bool>> createPost(String title, String content, List<String> tags)async {
    return await dataSource.createPost(title, content, tags);
  }
  @override
  Future<Either<Failure, List<ForumPostModel>>> getPost({required int page, required int limit})async {
    return await dataSource.getPost(page: page, limit: limit );
  }
  @override
  Future<Either<Failure, List<String>>> addlike(String postId) async{
    return await dataSource.addlike(postId);
  }
  @override
  Future<Either<Failure,CommentModel>> addComment(String postId, String content)async {
    return await dataSource.addComment(postId, content);
  }
  @override
  Future<Either<Failure, CommentReplyModel>> addCommentReply(String postId, String commentId, String content) async{
    return await dataSource.addCommentReply(postId, commentId, content);
  }
}