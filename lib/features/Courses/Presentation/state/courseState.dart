
import 'package:flutter/foundation.dart';
import 'package:llearning/features/Courses/data/model/course_model.dart';

class CourseState{
  final bool isLoading;
  final String? error;
  final List<CourseModel> courses;
  final CourseModel?  course;
  final bool hasReachedMax;
  final int page;

  CourseState({
   required this.isLoading,
   this.error,
    this.course,
   required this.courses,
    required this.hasReachedMax,
    required this.page,
});
  factory CourseState.initial(){
    return CourseState(isLoading: false,error: null,
    courses: [],course: null,hasReachedMax: false,page: 0);
  }
  CourseState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? page,
    List<CourseModel>? courses,
    CourseModel? course,
}){
    return CourseState(isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        course: course ?? this.course,
        courses: courses ??this.courses,hasReachedMax: hasReachedMax ?? this.hasReachedMax,page: page ?? this.page,);
  }

  @override
  String toString(){
    return 'CourseState(isLoading:$isLoading,error:$error,courses:$courses,course:$course)';
  }
}