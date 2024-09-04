import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/blog/domain/usecase/BlogUseCase.dart';

import '../state/blog_state.dart';
final blogViewModelProvider =StateNotifierProvider<BlogViewModel,BlogState>(
    (ref)=>BlogViewModel(blogUseCase: ref.read(blogUseCaseProvider)),
);
class BlogViewModel extends StateNotifier<BlogState>{
  BlogViewModel
      ({required this.blogUseCase}):
        super(BlogState.initial());
  final BlogUseCase blogUseCase;
  Future<void> getBlogs()async{
    state = state.copyWith(isLoading: true);
    final result= await blogUseCase.getBlogs();
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error), (blogs)=>state=state.copyWith(isLoading: false,blogs: blogs));
  }
}