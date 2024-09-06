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
    final currentState = state;
    final page = currentState.page + 1;
    final hasReachedMax = currentState.hasReachedMax;
    final blogs=currentState.blogs;
    if(!hasReachedMax) {
      final result = await blogUseCase.getBlogs(page: page, limit: 3);
      result.fold((failure) =>
      state = state.copyWith(isLoading: false, error: failure.error), (data){
        if(data.isEmpty){
          state=state.copyWith(hasReachedMax: true,isLoading: false);
        }else{
          state=state.copyWith(
            blogs: [...blogs,...data],
            page: page,
            isLoading: false,
          );
        }
      });
    }
  }
  Future<void> loadMoreBlogs() async{
    state = BlogState.initial();
    await getBlogs();
  }
}