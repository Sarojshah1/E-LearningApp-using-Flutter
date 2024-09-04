
import '../../data/model/blog_model.dart';

class BlogState{
  final bool isLoading;
  final String? error;
  final List<BlogModel> blogs;


  BlogState({
    required this.isLoading,
    this.error,
    required this.blogs,

  });
  factory BlogState.initial(){
    return BlogState(isLoading: false,error: null,
        blogs: []);
  }
  BlogState copyWith({
    bool? isLoading,
    String? error,
    List<BlogModel>? blogs
  }){
    return BlogState(isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      blogs: blogs ??this.blogs);
  }

  @override
  String toString(){
    return 'BlogState(isLoading:$isLoading,error:$error,blogs:$blogs)';
  }
}