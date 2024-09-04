import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/blog_model.dart';

abstract class BlogRepository{
  Future<Either<Failure,List<BlogModel>>> getBlogs();
}