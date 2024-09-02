
import 'package:llearning/features/Courses/data/model/ReviewModel.dart';

class ReviewState{
  final bool isLoading;
  final String? error;
  final List<ReviewModel> reviews;
  final bool hasReachedMax;
  final int page;

  ReviewState({
    required this.isLoading,
    this.error,
    required this.reviews,
    required this.hasReachedMax,
    required this.page,
  });
  factory ReviewState.initial(){
    return ReviewState(isLoading: false,error: null,
        reviews: [],hasReachedMax: false,page: 0);
  }
  ReviewState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? page,
    List<ReviewModel>? reviews
  }){
    return ReviewState(isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      reviews: reviews ??this.reviews,hasReachedMax: hasReachedMax ?? this.hasReachedMax,page: page ?? this.page,);
  }

  @override
  String toString(){
    return 'CourseState(isLoading:$isLoading,error:$error,reviews:$reviews)';
  }
}