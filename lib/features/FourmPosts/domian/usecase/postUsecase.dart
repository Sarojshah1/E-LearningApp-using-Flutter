import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/repositoryImpl/post_Repository_impl.dart';
import 'package:llearning/features/FourmPosts/domian/repository/postRepository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/ForumPostModel.dart';
final postUsecaseProvider =Provider.autoDispose<PostUseCase>((ref){
  return PostUseCase(repository: ref.read(postRepositoryImplProvider));
});
class PostUseCase{
  final PostRepository repository;
  PostUseCase({required this.repository});
  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags)async{
    return await repository.createPost(title, content, tags);
    
  }
  Future<Either<Failure,List<ForumPostModel>>> getPost({required int page, required int limit})async{
    return await repository.getPost(page: page, limit: limit);

  }
  Future<Either<Failure,List<String>>> addlike(String postId)async{
    return await repository.addlike(postId);
  }
  Future<Either<Failure, CommentModel>> addComment(String postId, String content)async{
    return await repository.addComment(postId, content);
  }
  Future<Either<Failure,ForumPostModel>> addCommentReply(String postId,String commentId,String content)async{
    return await repository.addCommentReply(postId, commentId, content);
  }
}