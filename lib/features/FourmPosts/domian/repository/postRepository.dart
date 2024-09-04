import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/ForumPostModel.dart';

abstract class PostRepository{
  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags);
  Future<Either<Failure,List<ForumPostModel>>> getPost();
}