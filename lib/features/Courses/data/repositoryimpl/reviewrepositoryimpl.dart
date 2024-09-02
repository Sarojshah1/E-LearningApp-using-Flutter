import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/data/data_Source/reviewRemotedataSoursce.dart';
import 'package:llearning/features/Courses/domain/repository/ReviewRepository.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../model/ReviewModel.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  if (connectivityStatus == ConnectivityStatus.isConnected) {
    final reviewRemoteDataSource = ref.read(reviewRemoteDataSourseProvider);
    return ReviewRepositoryImpl(remoteDataSource: reviewRemoteDataSource);
  } else {
    throw Exception('No internet connection');
  }
});
class ReviewRepositoryImpl extends ReviewRepository{
  final ReviewRemoteDataSource remoteDataSource;
  ReviewRepositoryImpl({
    required this.remoteDataSource
});
  @override
  Future<Either<Failure, List<ReviewModel>>> getReviews(String courseId) async{
    return await remoteDataSource.getReviews(courseId);
  }
  @override
  Future<Either<Failure, bool>> addreview(String courseId, String comment, int rating) async{
   return await remoteDataSource.addreview(courseId, comment, rating);
  }
}