import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/blog/data/data_source/blogremotedatasource.dart';
import 'package:llearning/features/blog/domain/repository/blog_repository.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';
import '../model/blog_model.dart';
final BlogRepositoryProvider = Provider<BlogRepository>((ref) {
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  if (connectivityStatus == ConnectivityStatus.isConnected) {
    final blogRemoteDataSource = ref.read(blogRemoteDataSourceProvider);
    return BlogRepositoryImpl(remoteDataSource: blogRemoteDataSource);
  } else {
    throw Exception('No internet connection');
  }
});
class BlogRepositoryImpl extends BlogRepository{
  final BlogRemoteDataSource remoteDataSource;
  BlogRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<BlogModel>>> getBlogs({required int page, required int limit}) async{
    return await remoteDataSource.getBlogs(page: page, limit: limit);
  }
}