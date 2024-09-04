import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/FourmPosts/domian/usecase/postUsecase.dart';
import 'package:llearning/features/FourmPosts/presentation/state/ForumPostState.dart';

final postViewModelProvider = StateNotifierProvider<PostViewModel, ForumPostState>(
      (ref) => PostViewModel(ref.read(postUsecaseProvider))
);
class PostViewModel extends StateNotifier<ForumPostState>{

  final PostUseCase useCase;
  PostViewModel(this.useCase):super(ForumPostState.initial());

  Future<void> createPost(String title,String content,List<String> tags)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.createPost(title, content, tags);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (success)=>state=state.copyWith(isLoading: false));
  }

}