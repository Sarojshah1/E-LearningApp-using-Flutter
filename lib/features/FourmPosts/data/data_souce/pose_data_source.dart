import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/App/constants/api_endpoints.dart';
import 'package:llearning/cores/failure/failure.dart';

import '../../../../cores/Networking/http_service.dart';
import '../../../../cores/shared_pref/user_shared_pref.dart';
import '../model/ForumPostModel.dart';
final FormPostDataSourceProvider=Provider<FormPostDataSource>(
    (ref)=>FormPostDataSource(dio: ref.watch(httpServiceProvider), userSharedPrefs: ref.watch(userSharedPrefsProvider))
);
class FormPostDataSource{
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FormPostDataSource({
    required this.dio,
    required this.userSharedPrefs
});

  Future<Either<Failure,bool>> createPost(String title,String content,List<String> tags)async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.post(ApiEndpoints.createPost,
        data: {
        "title":title,
          "content":content,
          "tags":tags
        },
        options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      ),);
      if(response.statusCode==201){
        return right(true);
      }else{
        return left(Failure(error: "failed to create post"));
      }

    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }

  Future<Either<Failure,List<ForumPostModel>>> getPost({required int page, required int limit})async{
    try{
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );
      Response response=await dio.get(ApiEndpoints.getPost,
        queryParameters: {
        'page': page,
        'limit': limit,
        },
          options: Options(
            headers: {
              'Authorization': 'Bearer $authToken',
            },
          ));
      if(response.statusCode==200){
        final List<dynamic> postJson=response.data;
        final List<ForumPostModel> posts=postJson.map((json) => ForumPostModel.fromJson(json))
            .toList();
        return right(posts);
      }else{
        return left(Failure(error: "Failed to load posts"));
      }

    }on DioException catch(e){
      return left(Failure(error: e.error.toString()));
    }

  }

  Future<Either<Failure, List<String>>> addlike(String postId) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      Response response = await dio.post(
        ApiEndpoints.getpostlikeUrl(postId),
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      if (response.statusCode == 201) {
        // Assuming the backend returns a list of likes
        if (response.data['likes'] is List) {
          final likesList = response.data['likes'] as List;
          // Optionally, you can validate the content of the list if needed
          final likes = likesList.map((like) => like.toString()).toList();
          return right(likes);
        } else {
          return left(Failure(error: "Response data is not a list of likes"));
        }
      } else {
        return left(Failure(error: "Failed to like post"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, CommentModel>> addComment(String postId, String content) async {
    print("Adding comment: $content");
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      Response response = await dio.post(
        ApiEndpoints.getpostcommentUrl(postId),
        data: {"content": content},
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // Handle cases where response.data might be a List or Map
        if (response.data['comments'] is List) {
          final commentsList = response.data['comments'] as List;
          if (commentsList.isNotEmpty) {
            final commentData = commentsList.last; // Retrieve the last comment
            if (commentData is Map<String, dynamic>) {
              final CommentModel model = CommentModel.fromJson(commentData);
              print("New CommentModel: $model");
              return right(model);
            } else {
              return left(Failure(error: "Comment data is not in the expected map format"));
            }
          } else {
            return left(Failure(error: "No comments found in the response"));
          }
        } else if (response.data['comments'] is Map<String, dynamic>) {
          final commentData = response.data['comments'] as Map<String, dynamic>;
          final CommentModel model = CommentModel.fromJson(commentData);
          print("New CommentModel: $model");
          return right(model);
        } else {
          return left(Failure(error: "Response data is not in the expected format"));
        }
      } else {
        return left(Failure(error: "Failed to add comment to the post"));
      }
    } on DioException catch (e) {
      print("DioException: ${e.toString()}");
      return left(Failure(error: e.error.toString()));
    }
  }


  Future<Either<Failure, CommentReplyModel>> addCommentReply(
      String postId, String commentId, String content) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold(
            (l) => throw Failure(error: l.error),
            (r) => r,
      );

      // Sending the request to add a comment reply
      Response response = await dio.post(
        ApiEndpoints.getpostcommentReplyUrl(postId, commentId),
        data: {
          "content": content,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      // Check if the response is successful and contains the expected data
      if (response.statusCode == 200 && response.data != null) {
        // Ensure the response contains comments and replies
        if (response.data['comments'] != null && response.data['comments'] is List) {
          // Find the specific comment and its replies
          final List comments = response.data['comments'];

          // Find the target comment by its ID and extract replies
          final targetComment = comments.firstWhere(
                (comment) => comment['id'] == commentId,
            orElse: () => null,
          );

          if (targetComment != null && targetComment['replies'] != null) {
            final repliesList = targetComment['replies'] as List;

            // Ensure there are replies and the last one is valid
            if (repliesList.isNotEmpty) {
              final replyData = repliesList.last;

              // Check if reply data is in the correct format
              if (replyData is Map<String, dynamic>) {
                final CommentReplyModel model = CommentReplyModel.fromJson(replyData);
                print("New CommentReplyModel: $model");
                return right(model);
              } else {
                return left(Failure(error: "Reply data is not in the expected map format"));
              }
            } else {
              return left(Failure(error: "No replies found in the comment"));
            }
          } else {
            return left(Failure(error: "Comment not found or missing replies"));
          }
        } else {
          return left(Failure(error: "Invalid comments data format in the response"));
        }
      } else {
        return left(Failure(error: "Failed to add reply, unexpected server response"));
      }
    } on DioException catch (e) {
      return left(Failure(error: e.error.toString()));
    }
  }

}