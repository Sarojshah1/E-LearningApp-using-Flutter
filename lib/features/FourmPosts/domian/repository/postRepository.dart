import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/ForumPostModel.dart';

abstract class PostRepository{
  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags);
  Future<Either<Failure,List<ForumPostModel>>> getPost({required int page, required int limit});
  Future<Either<Failure,List<String>>> addlike(String postId);
  Future<Either<Failure,CommentModel>> addComment(String postId,String content);
  Future<Either<Failure,ForumPostModel>> addCommentReply(String postId,String commentId,String content);
}