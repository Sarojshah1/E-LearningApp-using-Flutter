
import '../../data/model/blog_model.dart';

class BlogState{
  final bool isLoading;
  final String? error;
  final List<BlogModel> blogs;
  final bool hasReachedMax;
  final int page;


  BlogState({
    required this.isLoading,
    this.error,
    required this.blogs,
    required this.hasReachedMax,
    required this.page,

  });
  factory BlogState.initial(){
    return BlogState(isLoading: false,error: null,
        blogs: [],hasReachedMax: false,page: 0);
  }
  BlogState copyWith({
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? page,
    List<BlogModel>? blogs
  }){
    return BlogState(isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      blogs: blogs ??this.blogs,hasReachedMax: hasReachedMax ?? this.hasReachedMax,page: page ?? this.page,);
  }

  @override
  String toString(){
    return 'BlogState(isLoading:$isLoading,error:$error,blogs:$blogs)';
  }
}