import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/data/data_souce/pose_data_source.dart';
import 'package:llearning/features/FourmPosts/domian/repository/postRepository.dart';

import '../../../../cores/common/internet_connectivity.dart';
import '../../../../cores/failure/failure.dart';

final postRepositoryImplProvider=Provider<PostRepository>(
    (ref){
      final connectivityStatus = ref.watch(connectivityStatusProvider);

      if (connectivityStatus == ConnectivityStatus.isConnected) {
        final postRemoteDataSource = ref.read(FormPostDataSourceProvider);
        return PostRepositoryImpl(dataSource: postRemoteDataSource);
      } else {
        throw Exception('No internet connection');
      }
    }
);
class PostRepositoryImpl extends PostRepository{
  final FormPostDataSource dataSource;
  PostRepositoryImpl({
    required this.dataSource
});
  @override
  Future<Either<Failure, bool>> createPost(String title, String content, List<String> tags)async {
    return await dataSource.createPost(title, content, tags);
  }
}