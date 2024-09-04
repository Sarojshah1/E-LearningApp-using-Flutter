import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/repositoryImpl/post_Repository_impl.dart';
import 'package:llearning/features/FourmPosts/domian/repository/postRepository.dart';

import '../../../../cores/failure/failure.dart';
final postUsecaseProvider =Provider.autoDispose<PostUseCase>((ref){
  return PostUseCase(repository: ref.read(postRepositoryImplProvider));
});
class PostUseCase{
  final PostRepository repository;
  PostUseCase({required this.repository});
  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags)async{
    return await repository.createPost(title, content, tags);
    
  }
}