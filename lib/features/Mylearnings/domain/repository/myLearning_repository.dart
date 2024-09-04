import 'package:dartz/dartz.dart';

import '../../../../cores/failure/failure.dart';
import '../../data/model/mylearningModel.dart';

abstract class MyLearningRepository{
  Future<Either<Failure, List<EnrollmentModel>>> getLearnings();
}