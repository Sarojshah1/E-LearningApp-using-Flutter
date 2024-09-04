
import 'package:llearning/features/Mylearnings/data/model/mylearningModel.dart';

class EnrolledState{
  final bool isLoading;
  final String? error;
  final List<EnrollmentModel> enrolled;


  EnrolledState({
    required this.isLoading,
    this.error,
    required this.enrolled,

  });
  factory EnrolledState.initial(){
    return EnrolledState(isLoading: false,error: null,
        enrolled: []);
  }
  EnrolledState copyWith({
    bool? isLoading,
    String? error,
    List<EnrollmentModel>? enrolled
  }){
    return EnrolledState(isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        enrolled: enrolled ??this.enrolled);
  }

  @override
  String toString(){
    return 'BlogState(isLoading:$isLoading,error:$error,enrolled:$enrolled)';
  }
}