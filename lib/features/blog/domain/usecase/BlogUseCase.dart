import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/blog/data/repositoryImpl/blog_repository_Impl.dart';
import 'package:llearning/features/blog/domain/repository/blog_repository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/blog_model.dart';
final blogUseCaseProvider=Provider.autoDispose<BlogUseCase>(
    (ref){
      return BlogUseCase(ref.read(BlogRepositoryProvider));
    }
);
class BlogUseCase{
  final BlogRepository blogRepository;
  BlogUseCase(this.blogRepository);
  Future<Either<Failure, List<BlogModel>>> getBlogs({required int page, required int limit})async{
    return await blogRepository.getBlogs(page: page, limit: limit);

  }
}