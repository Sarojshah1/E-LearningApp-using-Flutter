import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/Presentation/state/courseState.dart';
import 'package:llearning/features/Courses/domain/usecases/course_usecase.dart';
import 'dart:async';

final courseViewModelProvider = StateNotifierProvider<CourseViewModel, CourseState>(
      (ref) => CourseViewModel(
     courseUseCase: ref.read(courseUsecaseProvider),
  ),
);
class CourseViewModel extends StateNotifier<CourseState> {
  CourseViewModel({
   required this.courseUseCase
  }):super(CourseState.initial()){getCourses();}
  final CourseUseCase courseUseCase;
  Future getCourses() async{
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final hasReachedMax = currentState.hasReachedMax;
    final courses=currentState.courses;
    if(!hasReachedMax){
      final result= await courseUseCase.getCourses(page: page, limit: 10);
      result.fold((failure)=>state=state.copyWith(hasReachedMax: true,isLoading: false,error: failure.error), (data){
        if(data.isEmpty){
          state=state.copyWith(hasReachedMax: true,isLoading: false);
        }else{
          state=state.copyWith(
            courses: [...courses,...data],
            page: page,
            isLoading: false,
          );
        }
      });



    }

  }
  Future<void> loadMoreCourses() async{
    state = CourseState.initial();
    await getCourses();
  }
}