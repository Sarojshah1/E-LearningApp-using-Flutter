import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/ReviewModel.dart';

abstract class ReviewRepository{
  Future<Either<Failure,List<ReviewModel>>> getReviews(String courseId);
  Future<Either<Failure,ReviewModel>> addreview(String courseId,String comment,int rating);
}