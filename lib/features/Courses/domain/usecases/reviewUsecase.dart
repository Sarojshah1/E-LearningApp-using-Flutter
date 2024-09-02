import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/data/repositoryimpl/reviewrepositoryimpl.dart';
import 'package:llearning/features/Courses/domain/repository/ReviewRepository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/ReviewModel.dart';
final reviewusecaseprovider=Provider.autoDispose<ReviewUseCase>(
    (ref){
      return ReviewUseCase(ref.read(reviewRepositoryProvider));
    }

);
class ReviewUseCase{
  final ReviewRepository reviewRepository;
  ReviewUseCase(this.reviewRepository);
  Future<Either<Failure,List<ReviewModel>>> getReviews(String courseId)async{
    return await reviewRepository.getReviews(courseId);

  }

  Future<Either<Failure,bool>> addreview(String courseId,String comment,int rating)async{
    return await reviewRepository.addreview(courseId, comment, rating);
  }
}