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
  Future<void> getPost()async{
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final hasReachedMax = currentState.hasReachedMax;
    final posts=currentState.forumPosts;
    if(!hasReachedMax){
      final result=await useCase.getPost(page: page, limit: 3);

      result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
              (data){
                if(data.isEmpty){
                  state=state.copyWith(hasReachedMax: true,isLoading: false);
                }else{
                  state=state.copyWith(
                    forumPosts: [...posts,...data],
                    page: page,
                    isLoading: false,
                  );
                }
              });
    }

  }
  Future<void> addLike(String postId)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.addlike(postId);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (success){
              final updatedPosts = state.forumPosts.map((post) {
                if (post.id == postId) {
                  final updatedLikes = [...post.likes, success.toString()];
                  return post.copyWith(likes: updatedLikes);
                }
                return post;
              }).toList();
      state=state.copyWith(isLoading: false, forumPosts: updatedPosts,);
            });


  }
  Future<void> addComment(String postId,String content)async{
    print("viewmodel:$content");
    state = state.copyWith(isLoading: true);
    final result=await useCase.addComment(postId, content);

    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (success){
      print("viewmodel:${success.content}");
              final updatedPosts = state.forumPosts.map((post) {
                if (post.id == postId) {
                  return post.copyWith(comments: [...post.comments, success]);
                }
                print(post.comments);
                return post;
              }).toList();
      state=state.copyWith(isLoading: false,forumPosts: updatedPosts);
            });


  }
  Future<void> addCommentReply(String postId,String commentId,String content)async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.addCommentReply(postId, commentId, content);
    result.fold((failure)=>state=state.copyWith(isLoading: false,error: failure.error),
            (newReply){
              final updatedPosts = state.forumPosts.map((post) {
                if (post.id == postId) {
                  final updatedComments = post.comments.map((comment) {
                    if (comment.id == commentId) {
                      return comment.copyWith(
                        replies: List.from(comment.replies ?? [])..add(newReply),
                      );
                    }
                    return comment;
                  }).toList();

                  return post.copyWith(comments: updatedComments);
                }
                return post;
              }).toList();
      state=state.copyWith(isLoading: false,forumPosts: updatedPosts);
            });


  }
  Future<void> loadMorePosts() async{
    state = ForumPostState.initial();
    await getPost();
  }

}