import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Mylearnings/data/data_source/mylearningremote_data_source.dart';

import '../../../../cores/failure/failure.dart';
import '../../domain/repository/myLearning_repository.dart';
import '../model/mylearningModel.dart';

final MyLearningRepositoryProvider=Provider<MyLearningRepositoryImpl>(
    (ref)=>MyLearningRepositoryImpl(remoteDataSource: ref.read(myLearningRemoteDataSourceProvider))
);
class MyLearningRepositoryImpl extends MyLearningRepository{
  final MyLearningRemoteDataSource remoteDataSource;
  MyLearningRepositoryImpl({
    required this.remoteDataSource
});
  @override
  Future<Either<Failure, List<EnrollmentModel>>> getLearnings() async{
    return await remoteDataSource.getLearnings();
  }
  
}