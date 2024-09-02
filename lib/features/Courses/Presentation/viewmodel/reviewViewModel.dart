
import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Courses/Presentation/state/ReviewState.dart';
import 'package:llearning/features/Courses/domain/usecases/reviewUsecase.dart';
final reviewViewModelProvider = StateNotifierProvider<ReviewViewModel, ReviewState>(
      (ref) => ReviewViewModel(
    reviewUseCase: ref.read(reviewusecaseprovider),
  ),
);
class ReviewViewModel extends StateNotifier<ReviewState>{
  ReviewViewModel({
    required this.reviewUseCase
}):super(ReviewState.initial());
  final ReviewUseCase reviewUseCase;

  Future<void> getReviews(String courseId) async{
    state = state.copyWith(isLoading: true);
    final result=await reviewUseCase.getReviews(courseId);
    result.fold(
            (failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (reviews)=>state=state.copyWith(isLoading: false,reviews: [...reviews])
    );

  }
  Future<void> addReviews(String courseId,String comment,int rating)async{
    state = state.copyWith(isLoading: true);
    final result=await reviewUseCase.addreview(courseId, comment, rating);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (success)=>state=state.copyWith(isLoading: false));
  }
}