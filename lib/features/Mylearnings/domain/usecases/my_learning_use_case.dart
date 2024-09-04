import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Mylearnings/domain/repository/myLearning_repository.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/mylearningModel.dart';
import '../../data/repositoryImpl/MyLearningRepositoryImpl.dart';
final myLearningUsercaseProvider=Provider.autoDispose<MyLearningUseCase>(
    (ref){
      return MyLearningUseCase(ref.read(MyLearningRepositoryProvider));
    }

);
class MyLearningUseCase{
  final MyLearningRepository repository;
  MyLearningUseCase(
    this.repository
);
  Future<Either<Failure, List<EnrollmentModel>>> getLearnings() async{
    return repository.getLearnings();

  }
}